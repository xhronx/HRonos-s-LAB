/*
// Configure the Yandex.Cloud provider
provider "yandex" {
  token                    = "auth_token_here"
  service_account_key_file = "path_to_service_account_key_file"
  cloud_id                 = "cloud_id_here"
  folder_id                = "folder_id_here"
  zone                     = "ru-central1-a"
}

// Create a new instance
resource "yandex_compute_instance" "default" {
  ...
}
*/

#Описываем провайдеров 
terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

#Подключаем провайдера Яндекс
provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

/*ADD Задание B5.3.7*/
#Создаём сервисный аккаунт
resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name        = "sfadm"
  description = "sf service account to manage VMs"
}

resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = var.folder_id
  role   = "storage.editor"
  member = "serviceAccount:${yandex_iam_service_account.sa.id}"
}


/*
resource "yandex_vpc_network" "foo" {
  name = "lab-network"
}

resource "yandex_vpc_subnet" "foo" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = var.zone
  network_id     = yandex_vpc_network.foo.id
}

resource "yandex_compute_instance" "sf-vm-1" {
  name = "sf-vm-1"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd80jfslq61mssea4ejn"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.foo.id
    nat       = true
  }
  metadata = {
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

}
*/

/*
resource "yandex_vpc_network" "foo" {} # Создаем VPC

resource "yandex_vpc_subnet" "foo" { # Настраиваем VPC
  zone           = var.zone
  network_id     = yandex_vpc_network.foo.id # Берем output переменную из другого ресурса 
  v4_cidr_blocks = []
}
*/

/*
variable "zone" {                               
  description = "Use specific availability zone" 
  type        = string                          
  default     = "ru-central1-b"                 
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.73.0"
    }
  }
}

provider "yandex" {
  cloud_id                 = "ajeajiqbf4a9oe55bd6m"
  folder_id                = "SKILLBOX_PROJECT"
  zone                     = var.zone
}
*/


/*
variable "zone" {                                # Используем переменную для передачи в конфиг инфраструктуры
  description = "Use specific availability zone" # Опционально описание переменной
  type        = string                           # Опционально тип переменной
  default     = "ru-central1-a"                  # Опционально значение по умолчанию для переменной
}

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.60.0" # Фиксируем версию провайдера
    }
  }
}

# Документация к провайдеру тут https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs#configuration-reference
# Настраиваем the Yandex.Cloud provider
provider "yandex" {
  service_account_key_file = file("~/.sa.json")
  cloud_id                 = "MY_UNIQUE_ID"
  folder_id                = "SKILLBOX_PROJECT"
  zone                     = var.zone # зона, которая будет использована по умолчанию
}
*/

