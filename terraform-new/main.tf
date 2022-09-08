# Подключаем провайдера Яндекс
provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone[1]
}


# Описываем провайдеров
terraform {
  required_providers {
    yandex = {
      source  = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
      version = ">= 0.72.0"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_compute_instance" "sf-vm-1" {
  name = "sf-vm-1"
  zone      = var.zone[1]

  resources {
    cores  = 2
    memory = 4
  }

   boot_disk {
    initialize_params {
      image_id = "fd87uq4tagjupcnm376a"
    }
  }

  network_interface {
    subnet_id = "e2lmvltoff4a5ra8tg61"
  }

}