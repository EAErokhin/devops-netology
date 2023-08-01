## Домашнее задание к занятию «Введение в Terraform»
![Alt text](<Снимок экрана 2023-08-01 в 13.25.56.png>)
```bashTerraform v1.5.4on darwin_arm64```
### Задача 1
Изучите файл .gitignore. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?
В соответствии с указанным .gitignore файлом, допустимо сохранять личную, секретную информацию в файле с именем "personal.auto.tfvars" в директории проекта. 
Выполните код проекта. Найдите в state-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.
`jUk4RXRU30aRs3pj`
Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
В коде были пропущенные переменные, некоторые переменные начинались с цифры, а так же были опечатки.
Выполните код. В качестве ответа приложите вывод команды docker ps.
```bash
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES236dcd6a4d70 ff78c7a65ec2 "/docker-entrypoint.…" 18 seconds ago Up 16 seconds 0.0.0.0:8000->80/tcp example_jUk4RXRU30aRs3pj
```
Замените имя docker-контейнера в блоке кода на hello_world. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду terraform apply -auto-approve. Объясните своими словами, в чём может быть опасность применения ключа -auto-approve. В качестве ответа дополнительно приложите вывод команды docker ps.
Опасность применения ключа -auto-approve заключается в том, что вы не будете иметь возможности внимательно проверить изменения перед их применением. Если есть какие-либо ошибки или проблемы с вашими настройками, они могут привести к нежелательным результатам или даже потере данных.
```bash
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES09a1a20ef603 ff78c7a65ec2 "/docker-entrypoint.…" 15 seconds ago Up 15 seconds 0.0.0.0:8000->80/tcp hello_world.
```
Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.

```json
{ "version": 4, "terraform_version": "1.5.4", "serial": 11, "lineage": "955923ec-c280-0513-4006-2e01b7769cf2", "outputs": {}, "resources": [], "check_results": null}
```
Объясните, почему при этом не был удалён docker-образ nginx:latest. Ответ подкрепите выдержкой из документации провайдера docker.
Параметр `force_delete_image` запрещает Terraform удалить образ docker. Это значит, что при выполнении операции удаления ресурсов, Terraform не удалит образ, даже если он больше не используется. В документации провайдера Docker указано следующее:
"When deleting a container (using docker_container.resource.destroy or similar), by default the container with all its resources will be deleted. However, any images created from failed builds (such as with force_pull) will be retained. To remove these images, the cleanup option for the Docker daemon must be set, via the daemon configuration file (e.g., /etc/docker/daemon.json) or the command line option.
By default, this option is disabled. Terraform Docker provider does not implement image cleanup if the Docker daemon cleanup option is disabled/missing."
