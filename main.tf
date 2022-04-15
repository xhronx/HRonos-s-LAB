/*
#Описываем провайдеров 
terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
      #version = "0.73.0"
    }
  }
  required_version = ">= 0.13"
}
*/
#Подключаем провайдера Яндекс
provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}


#Описываем провайдеров 
terraform {
  required_providers {
    yandex = {
      source  = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
      version = "0.72.0"
    }
  }
  required_version = ">= 0.13"

  #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Configure the backend
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
}



#Create a bucket
resource "yandex_storage_bucket" "test" {
  access_key = yandex_iam_service_account_static_access_key.sasa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sasa-static-key.secret_key
  bucket     = "sf-tf-test-bucket-1"
}


/*ADD Задание B5.3.7*/
#Создаём сервисный аккаунт
resource "yandex_iam_service_account" "sasa" {
  folder_id   = var.folder_id
  name        = "xhronx"
  description = "sf service account to manage VMs"
}

#Даём sfadm права эдитора к моей папке в облаке
resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sasa.id}"
}

resource "yandex_iam_service_account_static_access_key" "sasa-static-key" {
  service_account_id = yandex_iam_service_account.sasa.id
  description        = "static access key for object storage sfamd"
}

resource "yandex_vpc_network" "foo" {
  name = "sf-network-1"
}

resource "yandex_vpc_subnet" "foo" {
  name           = "sf-subnet-1"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = var.zone
  network_id     = yandex_vpc_network.foo.id
}

data "yandex_compute_image" "my_image" {
  family = "lemp"
}

resource "yandex_compute_instance" "sf-vm-1" {
  name = "sf-vm-1"

  resources {
    cores  = 2
    memory = 2
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.foo.id
    nat       = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}