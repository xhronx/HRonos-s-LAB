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
variable "zone" {                               
  #description = "Use specific availability zone" 
  type        = string                          
  default     = "ru-central1-b"                 
}
terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "AQAAAAAH5YqGAATuwVbU9LsB-UxbtNbbW1ALXCc"
  cloud_id  = "b1gq09fegok6th6eku05"
  folder_id = "b1gc2kft2tqjiqe4it7d"
  zone      = var.zone
}



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

