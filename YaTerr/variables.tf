variable "zone" {
  #description = "Use specific availability zone" 
  type    = string
  default = "ru-central1-b"
}

variable "folder_id" {
  #description = "my folder_id yandex provider" 
  type    = string
  default = "b1gc2kft2tqjiqe4it7d"
}

variable "cloud_id" {
  #description = "my cloud_id yandex provider" 
  type    = string
  default = "b1gq09fegok6th6eku05"
}

variable "token" {
  #description = "my token yandex provider" 
  type    = string
  default = "AQAAAAAH5YqGAATuwVbU9LsB-UxbtNbbW1ALXCc"
}

/*
terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "<OAuth>"
  cloud_id  = "<идентификатор облака>"
  folder_id = "<идентификатор каталога>"
  zone      = "<зона доступности по умолчанию>"
}
*/

/*
#Например, через API провайдера можно узнать актуальные доступные образы для инстанса:

# тип ресурса — data
# название ресурса — aws_ami
# имя собственное для описания этого компонента — example (можно использовать любое в рамках конвенций)
data "aws_ami" "example" {
  most_recent = true # Если вернется много результатов, то показать только последний

  owners = ["self"] # Список владельцев образов
  tags = {          # Искать образ, которые содержит указанные теги
    Name   = "app-server"
    Tested = "true"
  }
}
*/

/*
data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.ini.tpl") # Путь до шаблона на локальном компьютере
  vars = {
    backend_ip  = "10.10.7.43" # Переменные, которые передаем в наш шаблон.
    frontend_ip = "10.10.8.33"
  }
  */

/*
  # Генерируем шаблон
data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.ini.tpl") # Путь до шаблона на локальном компьютере
  vars = {
    backend_ip  = "10.10.7.43"
    frontend_ip = "10.10.8.33"
  }
}

# Записываем сгенерированный шаблон в файл
resource "null_resource" "update_inventory" {
  triggers = { # Код будет выполнен, когда inventory будет сгенерирован
    template = data.template_file.ansible_inventory.rendered
  }
  provisioner "local-exec" { # выполняем команду на локальной машине
    command = "echo '${data.template_file.ansible_inventory.rendered}' > inventory.ini"
  }
}
*/

/*
Демонстрация работы data "terraform_remote_state" :

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    ...
  }
}
*/

/*
data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.ini.tpl") # Путь до шаблона на локальном компьютере
  vars = {
    backend_ip  = "10.10.7.43" # Переменные, которые передаем в наш шаблон.
    frontend_ip = "10.10.8.33"
  }
}

# Генерируем шаблон
data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.ini.tpl") # Путь до шаблона на локальном компьютере
  vars = {
    backend_ip  = "10.10.7.43"
    frontend_ip = "10.10.8.33"
  }
}

# Записываем сгенерированный шаблон в файл
resource "null_resource" "update_inventory" {
  triggers = { # Код будет выполнен, когда inventory будет сгенерирован
    template = data.template_file.ansible_inventory.rendered
  }
  provisioner "local-exec" { # выполняем команду на локальной машине
    command = "echo '${data.template_file.ansible_inventory.rendered}' > inventory.ini"
  }
}
*/

/*
# Создайте файл main.tf, в котором будет генерироваться файл inventory Ansible.
data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.ini.tpl") # Путь до шаблона на локальном компьютере
  vars = {
    webserver_1                  = "foo.example.com"
    webserver_2                  = "bar.example.com"
    dbserver_1                   = "one.example.com"
    dbserver_2                   = "two.example.com"
    dbserver_3                   = "three.example.com"
    ansible_ssh_private_key_file = "~/.ssh/git.pem"
    ansible_ssh_user             = "ubuntu"
  }
}

resource "null_resource" "update_inventory" {
  triggers = {
    template = data.template_file.ansible_inventory.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.ansible_inventory.rendered}' > inventory.ini"
  }
}

# Результатом работы должен быть файл с именем inventory.ini
*/

