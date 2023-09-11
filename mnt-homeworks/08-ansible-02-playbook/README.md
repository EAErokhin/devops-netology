# Домашнее задание к занятию 2 «Работа с Playbook»

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2.
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
```
Passed: 0 failure(s), 0 warning(s) on 1 files. Last profile that met the validation criteria was 'production'.
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
PLAY [Install Clickhouse] *****************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************
ok: [centos7]

TASK [Get clickhouse distrib 1] ***********************************************************************************************
changed: [centos7] => (item=clickhouse-client)
changed: [centos7] => (item=clickhouse-server)
failed: [centos7] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib 2] ***********************************************************************************************
changed: [centos7]

TASK [Install clickhouse packages] ********************************************************************************************
fatal: [centos7]: FAILED! => {"changed": false, "msg": "No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system", "rc": 127, "results": ["No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system"]}

PLAY RECAP ********************************************************************************************************************
centos7                    : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0   
```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```
PLAY [Install Clickhouse] *****************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************
ok: [centos7]

TASK [Get clickhouse distrib 1] ***********************************************************************************************
changed: [centos7] => (item=clickhouse-client)
changed: [centos7] => (item=clickhouse-server)
failed: [centos7] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib 2] ***********************************************************************************************
changed: [centos7]

TASK [Install clickhouse packages] ********************************************************************************************
changed: [centos7]

TASK [Flush handlers] *********************************************************************************************************

RUNNING HANDLER [Start clickhouse service] ************************************************************************************
changed: [centos7]

TASK [Create database] ********************************************************************************************************
changed: [centos7]

TASK [Download Vector] ********************************************************************************************************
changed: [centos7]

TASK [Install vector] *********************************************************************************************************
changed: [centos7]

TASK [Create Vector Configuration] ********************************************************************************************
--- before: /etc/vector/vector.toml
+++ after: /Users/e.a.erokhin/.ansible/tmp/ansible-local-79903s0ph9po4/tmpf9ep9ffx/vector_config.j2
@@ -1,44 +1,47 @@
-#                                    __   __  __
-#                                    \ \ / / / /
-#                                     \ V / / /
-#                                      \_/  \/
-#
-#                                    V E C T O R
-#                                   Configuration
-#
-# ------------------------------------------------------------------------------
-# Website: https://vector.dev
-# Docs: https://vector.dev/docs
-# Chat: https://chat.vector.dev
-# ------------------------------------------------------------------------------
+# Set global options
+data_dir = "/var/lib/vector"
 
-# Change this to use a non-default directory for Vector data storage:
-# data_dir = "/var/lib/vector"
+# Vector's API (disabled by default)
+# Enable and try it out with the `vector top` command
+[api]
+enabled = false
+# address = "127.0.0.1:8686"
 
-# Random Syslog-formatted logs
-[sources.dummy_logs]
-type = "demo_logs"
-format = "syslog"
-interval = 1
+# Ingest data by tailing one or more files
+[sources.apache_logs]
+type         = "file"
+include      = ["/var/log/apache2/*.log"]    # supports globbing
+ignore_older = 86400                         # 1 day
 
-# Parse Syslog logs
-# See the Vector Remap Language reference for more info: https://vrl.dev
-[transforms.parse_logs]
-type = "remap"
-inputs = ["dummy_logs"]
+# Structure and parse via Vector's Remap Language
+[transforms.apache_parser]
+inputs = ["apache_logs"]
+type   = "remap"
 source = '''
-. = parse_syslog!(string!(.message))
+. = parse_apache_log(.message)
 '''
 
-# Print parsed logs to stdout
-[sinks.print]
-type = "console"
-inputs = ["parse_logs"]
-encoding.codec = "json"
+# Sample the data to save on cost
+[transforms.apache_sampler]
+inputs = ["apache_parser"]
+type   = "sample"
+rate   = 2                    # only keep 50% (1/`rate`)
 
-# Vector's GraphQL API (disabled by default)
-# Uncomment to try it out with the `vector top` command or
-# in your browser at http://localhost:8686
-#[api]
-#enabled = true
-#address = "127.0.0.1:8686"
+# Send structured data to a short-term storage
+[sinks.es_cluster]
+inputs     = ["apache_sampler"]             # only take sampled data
+type       = "elasticsearch"
+endpoints  = ["http://79.12.221.222:9200"]  # local or external host
+bulk.index = "vector-%Y-%m-%d"              # daily indices
+
+# Send structured data to a cost-effective long-term storage
+[sinks.s3_archives]
+inputs          = ["apache_parser"]    # don't sample for S3
+type            = "aws_s3"
+region          = "us-east-1"
+bucket          = "my-log-archives"
+key_prefix      = "date=%Y-%m-%d"      # daily partitions, hive friendly format
+compression     = "gzip"               # compress final objects
+framing.method  = "newline_delimited"  # new line delimited...
+encoding.codec  = "json"               # ...JSON
+batch.max_bytes = 10000000             # 10mb uncompressed
\ No newline at end of file

changed: [centos7]

PLAY RECAP ********************************************************************************************************************
centos7                    : ok=7    changed=7    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0  
```
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
```
PLAY [Install Clickhouse] *****************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************
ok: [centos7]

TASK [Get clickhouse distrib 1] ***********************************************************************************************
ok: [centos7] => (item=clickhouse-client)
ok: [centos7] => (item=clickhouse-server)
failed: [centos7] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "builder", "item": "clickhouse-common-static", "mode": "0777", "msg": "Request failed", "owner": "builder", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib 2] ***********************************************************************************************
ok: [centos7]

TASK [Install clickhouse packages] ********************************************************************************************
ok: [centos7]

TASK [Flush handlers] *********************************************************************************************************

TASK [Create database] ********************************************************************************************************
ok: [centos7]

TASK [Download Vector] ********************************************************************************************************
ok: [centos7]

TASK [Install vector] *********************************************************************************************************
ok: [centos7]

TASK [Create Vector Configuration] ********************************************************************************************
ok: [centos7]

PLAY RECAP ********************************************************************************************************************
centos7                    : ok=7    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
```
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook).

# Install ClickHouse and Vector Playbook Documentation

## Overview

This Ansible playbook is designed to automate the installation and configuration of ClickHouse and Vector on a remote CentOS 7 server. ClickHouse is a columnar database, and Vector is a tool for collecting, tagging, and forwarding logs.

## Usage

1. Ensure Ansible is installed on your CentOS 7 server.

2. Create an inventory for your target (e.g., in a file named `inventory.ini`).

3. Create and configure an Ansible configuration file as needed.

4. Run the playbook using your preferred method to execute Ansible playbooks.

## Tasks

The playbook performs the following tasks:

### Install ClickHouse

1. Downloads and installs ClickHouse packages on the server.

2. Creates a "logs" database in ClickHouse.

### Install Vector

3. Downloads and installs the Vector package on the server.

### Configure Vector

4. Creates a Vector configuration file using the `vector_config.j2` template and places it in `/etc/vector/vector.toml`.

### Restart Services

5. Restarts the ClickHouse and Vector services to apply changes.

## Handlers

Handlers in the playbook perform the following actions:

### Start ClickHouse Service

Restarts the ClickHouse service after installation and configuration.

### Restart Vector

Restarts the Vector service after installation and configuration.

## Important Notes

- Before running this playbook, ensure you have configured the inventory and variables according to your requirements.

- Make sure to replace file paths and configuration data in the playbook to match your directory structure.

- Ensure that the Vector configuration file (`vector_config.j2`) is correct and meets your needs.

- This playbook is developed and tested on CentOS 7 and may require adjustments for other OS versions.

- Be sure to have the necessary permissions and access rights to perform operations on the server.


10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
