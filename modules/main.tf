#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#Описываем провайдеров 
terraform {
  required_providers {
    yandex = {
      source  = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
      version = "0.72.0"
    }
  }
  #required_version = ">= 0.13"

  #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Configure the backend
  /*
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "sf-tf-test-bucket-1"
    region     = "ru-central1-b"
    key        = "Terraform-states/yac-state-1/terraform.tfstate"
    access_key = "YCAJEWuVkETRZRfAhaB0PIShG"
    secret_key = "YCP2Eel0gp1QiYB1jfvjEnQ5D4MoitvIam4d-i5I"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
  */
}
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


data "yandex_compute_image" "my_image" {
  family = var.instance_family_image
}

resource "yandex_compute_instance" "sf-vm" {
  name = "sf-modules-${var.instance_family_image}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}