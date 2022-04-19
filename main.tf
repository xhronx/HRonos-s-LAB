
#Подключаем провайдера Яндекс
provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone[1]
}
#
#Описываем провайдеров
terraform {
  required_providers {
    yandex = {
      source  = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
      version = ">= 0.72.0"
    }
  }
  required_version = ">= 0.13"
  
  #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Configure the backend
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "sf-tf-test-bucket-1"
    region     = "ru-central1-b"
    key        = "Terraform-states/yac-state-1/terraform.tfstate"
    access_key = "YCAJET00zZft3mRnJdUIZZIbn"
    secret_key = "YCNyRDhb495yAfXWX8vS-aCjqq7X5Xg0S8GgRH9C"

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


#Создаём сервисный аккаунт
resource "yandex_iam_service_account" "sasa" {
  folder_id   = var.folder_id
  name        = "sasa"
  description = "sf service account to manage VMs"
}

#Создаём сервисный аккаунт
resource "yandex_iam_service_account" "papa" {
  folder_id   = var.folder_id
  name        = "papa"
  description = "sf service account to manage VMs"
}

/*
#Даём sfadm права эдитора к моей папке в облаке
resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sasa.id}"
}
*/

resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = var.folder_id
  role = var.roles[0]
  #role = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sasa.id}"
}

resource "yandex_iam_service_account_static_access_key" "sasa-static-key" {
  service_account_id = yandex_iam_service_account.sasa.id
  description        = "static access key for object storage sfamd"
}

resource "yandex_iam_service_account_static_access_key" "papa-static-key" {
  service_account_id = yandex_iam_service_account.papa.id
  description        = "static access key for object storage sfamd"
}

resource "yandex_vpc_network" "foo" {
  name = "sf-network-1"
}

resource "yandex_vpc_subnet" "foo" {
  name           = "sf-subnet-1"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = var.zone[1]
  network_id     = yandex_vpc_network.foo.id
}

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
resource "yandex_vpc_subnet" "subnet1" {
  name = "subnet1"
  zone = var.zone[1]
  #zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}

resource "yandex_vpc_subnet" "subnet2" {
  name = "subnet2"
  zone = var.zone[1]
  #zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["192.168.12.0/24"]
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
      #image_id = data.yandex_compute_image.my_image.id
      image_id = "fd81hgrcv6lsnkremf32"
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}


# MODULES + !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
module "module_instance_1" {
  source                = "./modules"
  instance_family_image = "lemp"
  vpc_subnet_id         = yandex_vpc_subnet.subnet1.id
}

module "module_instance_2" {
  source                = "./modules"
  instance_family_image = "lamp"
  vpc_subnet_id         = yandex_vpc_subnet.subnet2.id
}

/*
# Network Load Balancer + #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
resource "yandex_lb_network_load_balancer" "internal-lb-test" {
  name = "internal-lb-test"
  type = "internal"

  listener {
    name = "my-listener"
    port = 8080
    internal_address_spec {
      #address = "<внутренний IP-адрес>"
      #subnet_id = "<идентификатор подсети>"
      address = "192.168.10.2"
      subnet_id = yandex_vpc_subnet.foo.id
    }
  }
}
*/
/*
# Network Load Balancer + #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
resource "yandex_lb_network_load_balancer" "internal-lb-test" {
  name = "internal-lb-test"
  type = "internal"

  listener {
    name = "my-listener"
    port = 8080
    internal_address_spec {
      ip_version = "ipv4"
      #address = "<внутренний IP-адрес>"
      #subnet_id = "<идентификатор подсети>"
      address = "192.168.10.2"
      subnet_id = yandex_vpc_subnet.foo.id
    }
  }
  
  attached_target_group {
    target_group_id = yandex_lb_target_group.foo.id
    
    healthcheck {
      name = "healthcheck"
      http_options {
        port = 80
        path = "/"
      }
    }
    
  }
  
}

*/




resource "yandex_lb_target_group" "foo" {
  name      = "my-target-group"

  target {
    #subnet_id = "<идентификатор подсети>"
    #address   = "<внутренний IP-адрес ресурса>"
    subnet_id = yandex_vpc_subnet.subnet1.id
    address   = module.module_instance_1.internal_ip_address_vm
  }

  target {
    #subnet_id = "<идентификатор подсети>"
    #address   = "<внутренний IP-адрес ресурса 2>"
    subnet_id = yandex_vpc_subnet.subnet2.id
    address   = module.module_instance_2.internal_ip_address_vm
  }

}
 