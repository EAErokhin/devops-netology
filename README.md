## Домашнее задание к занятию «Введение в Terraform»


```bash
Terraform v1.5.4
on darwin_arm64
```

### Задача 1

Изучите файл .gitignore. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?

В соответствии с указанным .gitignore файлом, допустимо сохранять личную, секретную информацию в файле с именем "personal.auto.tfvars" в директории проекта. 

Выполните код проекта. Найдите в state-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.

jUk4RXRU30aRs3pj

Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.

В коде были пропущенные переменные, некоторые переменные начинались с цифры, а так же были опечатки.

Выполните код. В качестве ответа приложите вывод команды docker ps.

```bash
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
236dcd6a4d70   ff78c7a65ec2   "/docker-entrypoint.…"   18 seconds ago   Up 16 seconds   0.0.0.0:8000->80/tcp   example_jUk4RXRU30aRs3pj
```

Замените имя docker-контейнера в блоке кода на hello_world. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду terraform apply -auto-approve. Объясните своими словами, в чём может быть опасность применения ключа  -auto-approve. В качестве ответа дополнительно приложите вывод команды docker ps.

Опасность применения ключа -auto-approve заключается в том, что вы не будете иметь возможности внимательно проверить изменения перед их применением. Если есть какие-либо ошибки или проблемы с вашими настройками, они могут привести к нежелательным результатам или даже потере данных.

```bash
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
09a1a20ef603   ff78c7a65ec2   "/docker-entrypoint.…"   15 seconds ago   Up 15 seconds   0.0.0.0:8000->80/tcp   hello_world.
```

Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.


```json
{
  "version": 4,
  "terraform_version": "1.5.4",
  "serial": 11,
  "lineage": "955923ec-c280-0513-4006-2e01b7769cf2",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```

Объясните, почему при этом не был удалён docker-образ nginx:latest. Ответ подкрепите выдержкой из документации провайдера docker.

По умолчанию команда terraform destroy не удаляет docker-образы, только контейнеры и сети. В документации провайдера Docker сказано следующее: "Note that terraform destroy does not attempt to destroy or de-register the Docker Image. Doing so could result in accidentally deleting an image that is still being used by other workloads. Deleting an Image is outside the scope of the Terraform Docker provider, and is typically handled directly with custom scripts or with other container management tools."