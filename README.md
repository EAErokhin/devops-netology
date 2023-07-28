## Домашнее задание к занятию 4. «Оркестрация группой Docker-контейнеров на примере Docker Compose»

### Задача 1

![Alt text](<Снимок экрана 2023-07-28 в 17.52.03.png>)

### Задача 2

![Alt text](<Снимок экрана 2023-07-28 в 17.37.02.png>)

### Задача 3

```bash
[centos@netology ~]$ sudo docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREATED          STATUS                    PORTS                                                                              NAMES
c09fafac964e   prom/prometheus:v2.17.1            "/bin/prometheus --c…"   12 minutes ago   Up 12 minutes             9090/tcp                                                                           prometheus
c91845dfeed3   prom/node-exporter:v0.18.1         "/bin/node_exporter …"   12 minutes ago   Up 12 minutes             9100/tcp                                                                           nodeexporter
1e1683464210   grafana/grafana:7.4.2              "/run.sh"                12 minutes ago   Up 12 minutes             3000/tcp                                                                           grafana
f4d43c48afd1   stefanprodan/caddy                 "/sbin/tini -- caddy…"   12 minutes ago   Up 12 minutes             0.0.0.0:3000->3000/tcp, 0.0.0.0:9090-9091->9090-9091/tcp, 0.0.0.0:9093->9093/tcp   caddy
c719e16e07de   gcr.io/cadvisor/cadvisor:v0.47.0   "/usr/bin/cadvisor -…"   12 minutes ago   Up 12 minutes (healthy)   8080/tcp                                                                           cadvisor
c7bcbaacfc2a   prom/pushgateway:v1.2.0            "/bin/pushgateway"       12 minutes ago   Up 12 minutes             9091/tcp                                                                           pushgateway
678886d14c5c   prom/alertmanager:v0.20.0          "/bin/alertmanager -…"   12 minutes ago   Up 12 minutes             9093/tcp                                                                           alertmanager
```
![Alt text](<Снимок экрана 2023-07-28 в 17.48.10.png>)
### Задача 4

![Alt text](<Снимок экрана 2023-07-28 в 17.50.15.png>)