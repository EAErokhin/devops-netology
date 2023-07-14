# devops-netology

файл .gitignore указывает, что следующие файлы и папки должны быть проигнорированы:

Все локальные директории .terraform
Файлы .tfstate и .tfstate.*
Файлы crash.log и crash.*.log
Все файлы .tfvars и .tfvars.json
Файлы override.tf, override.tf.json, *_override.tf и *_override.tf.json
Файлы terraformrc и terraform.rc.


## Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения

### Задача 1

Полная виртуализация (аппаратная виртуализация) - это метод, при котором виртуальная машина (ВМ) полностью изолирована от хост-системы, воссоздавая виртуальное окружение с полным доступом к аппаратным ресурсам. Для этого требуется гипервизор, который разделяет физические ресурсы между ВМ.

Паравиртуализация - это метод, при котором гостевые операционные системы модифицированы, чтобы осознавать, что они работают под гипервизором. Гостевые ОС взаимодействуют напрямую с гипервизором, используя специальные драйверы. Паравиртуализация требует модификации операционной системы для поддержки этого вида виртуализации.

Виртуализация на основе ОС - это метод, при котором хост-система обеспечивает виртуализацию путем запуска множества изолированных контейнеров или виртуальных машин на одной экземпляре операционной системы. Каждый контейнер или виртуальная машина имеет свою собственную изолированную среду, включая файловую систему, процессы и сетевые ресурсы.

### Задача 2

Высоконагруженная база данных, чувствительная к отказу - для этого случая предпочтительна физическая организация серверов. Физические серверы обеспечивают высокую производительность, низкую задержку и высокую отказоустойчивость, что критично для такой базы данных.

Различные web-приложения - для этого случая предпочтительна виртуализация на уровне ОС. Виртуализация на уровне ОС позволяет запускать множество изолированных контейнеров или виртуальных машин на одном экземпляре операционной системы. Это удобно для хостинга различных web-приложений, так как каждое приложение имеет свою изолированную среду, что обеспечивает безопасность и гибкость.

Windows-системы для использования бухгалтерским отделом - для этого случая также предпочтительна виртуализация на уровне ОС. Виртуализация на уровне ОС позволяет запускать несколько экземпляров операционной системы на одном сервере, что удобно для ситуаций, когда требуется запуск Windows-систем для различных отделов или пользователей.

Системы, выполняющие высокопроизводительные расчёты на GPU - для этого случая предпочтительна паравиртуализация. Паравиртуализация позволяет гостевым операционным системам взаимодействовать напрямую с гипервизором, включая доступ к аппаратным ресурсам, таким как GPU. Это обеспечивает максимальную производительность и эффективность для таких высокопроизводительных расчетов.

### Задача 3

1. Для сценария с 100 виртуальными машинами на базе Linux и Windows, репликацией данных и программными балансировщиками нагрузки, можно рассмотреть использование гипервизора VMware ESXi. Он предоставляет широкий набор функциональных возможностей, включая функции репликации данных и балансировки нагрузки, а также автоматизированный механизм создания резервных копий. VMware ESXi обладает превосходной производительностью и надежностью, и широко используется в корпоративной среде.

2. Для сценария с небольшой инфраструктурой на базе Linux и Windows виртуальных машин, требующей производительного и бесплатного Open-Source решения, рекомендуется использовать гипервизор KVM (Kernel-based Virtual Machine). KVM интегрирован в ядро Linux и предоставляет полную виртуализацию, поддержку как Linux-виртуальных машин, так и Windows-виртуальных машин. KVM обладает отличной производительностью и поддерживает как управление через командную строку, так и графический пользовательский интерфейс.

3. Для сценария с Windows-инфраструктурой, требующей бесплатное, совместимое и производительное решение, рекомендуется использовать гипервизор Hyper-V. Hyper-V является встроенным гипервизором в операционных системах Windows Server и поддерживает запуск Windows-виртуальных машин. Он обладает высокой производительностью, надежностью и интегрирован с другими службами и функциональностью операционной системы Windows Server.

4. Для сценария с тестированием программного продукта на различных дистрибутивах Linux, рекомендуется использовать гипервизор VirtualBox. VirtualBox является бесплатным и мультиплатформенным гипервизором, поддерживающим различные операционные системы, включая Linux. Он обладает простым в использовании интерфейсом, поддержкой сетевого взаимодействия и различными функциональными возможностями для создания и управления виртуальными машинами.

### Задача 4

Проблемы и недостатки гетерогенной среды виртуализации могут быть следующими:

1. Сложность управления: Использование нескольких систем управления виртуализацией одновременно может привести к повышенной сложности управления. Каждая система требует своего специфического набора инструментов и знаний, что может затруднять администрирование и мониторинг всей инфраструктуры.

2. Интеграционные проблемы: Гетерогенная среда виртуализации может вызвать проблемы с интеграцией между различными системами управления виртуализацией. Например, возможны ограничения в обмене данными или управлении виртуальными машинами между разными платформами.

3. Усложненная обучаемость: Персонал должен быть обучен в использовании нескольких разных систем управления виртуализацией, что может потребовать дополнительных ресурсов и времени.

4. Увеличенные затраты на лицензирование и обслуживание: Каждая система управления виртуализацией может требовать своих лицензий и поддержки, что может привести к дополнительным затратам.

Для минимизации рисков и проблем гетерогенной среды виртуализации можно применить следующие подходы:

1. Стандартизация процессов и настроек: Создание общих стандартов и процедур для управления и настройки виртуальных машин в разных системах поможет упростить процесс администрирования.

2. Автоматизация управления: Использование инструментов автоматизации, таких как системы оркестрации, поможет упростить и автоматизировать управление и мониторинг гетерогенной среды.

3. Правильный выбор систем управления виртуализацией: При создании гетерогенной среды следует тщательно выбирать системы управления виртуализацией, учитывая их совместимость, функциональные возможности и требования вашей инфраструктуры.

Если бы у меня был выбор, я бы стремился к минимизации гетерогенности среды виртуализации, особенно если это необходимо для оптимальной работы команды и уменьшения затрат на обслуживание и обучение. Однако иногда существуют конкретные требования или ограничения, которые могут потребовать применения гетероген

## Домашнее задание к занятию 2. «Применение принципов IaaC в работе с виртуальными машинами»

### Задача 1
Основные преимущества применения на практике IaaC-паттернов включают:

1. Автоматизация: IaaC позволяет автоматизировать процессы развертывания, конфигурации и управления инфраструктурой, что увеличивает скорость и надежность разработки.

2. Однородность: IaaC позволяет создавать консистентные и повторяемые конфигурации инфраструктуры. Это упрощает управление и отладку, а также позволяет легко масштабировать или изменять инфраструктуру.

3. Гибкость: IaaC позволяет быстро адаптироваться к изменениям требований и масштабировать инфраструктуру в соответствии с растущими потребностями бизнеса.

4. Версионирование: IaaC позволяет хранить и управлять конфигурацией в системе контроля версий, что облегчает сотрудничество, обнаружение ошибок и восстановление из предыдущих версий.

Основополагающим принципом IaaC является представление инфраструктуры в виде кода. Это означает, что конфигурация инфраструктуры должна быть указана в виде программного кода, который может быть автоматизировано развернут и управляем с помощью инструментов IaaC.

### Задача 2

Ansible выгодно отличается от других систем управления конфигурациями следующими особенностями:

1. Агентлесс архитектура: Ansible работает по принципу push-модели, что означает, что не требуется установка агентов на удаленные узлы. Это упрощает и ускоряет развертывание и управление.

2. Простота и понятность: Ansible использует язык описания конфигурации YAML, который легко читать и писать. Это делает процесс разработки и поддержки инфраструктуры более простым.

3. Масштабируемость: Ansible позволяет управлять сотнями и даже тысячами узлов одновременно, благодаря параллельному выполнению задач.

В отношении выбора метода работы систем конфигурации, надежность может зависеть от контекста и требований системы. В общем случае, метод pull-модели более надежен, так как узлы самостоятельно обновляются и получают актуальную конфигурацию с центрального сервера. Однако, метод push-модели может быть применим, если требуется большая гибкость и независимость узлов.

### Задача 3

VirtualBox
```bash
7.0.4_Ubuntu155176
```

Vagrant
```bash
Vagrant 2.3.7
```

Terraform
```bash
Terraform v1.5.3
on Linux_amd64
```

Ansible
```bash
ansible [core 2.14.2]
  config file = none
  configured module search path = ['/home/eugene/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/eugene/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.11.2 (maun, May 30 2023, 17:45:26) [GCC 12.2.0] (/usr/bin/python3)
  jinja version = 3.1.2
  libbyaml = True
  ```

### Задача 4

  ![Alt text](<Снимок экрана 2023-07-14 в 12.42.08.png>)

## Домашнее задание к занятию 3. «Введение. Экосистема. Архитектура. Жизненный цикл Docker-контейнера»

### Задача 1

