output "access_key" {
  value     = yandex_iam_service_account_static_access_key.sasa-static-key.access_key
  sensitive = false
}

output "secret_key" {
  value     = yandex_iam_service_account_static_access_key.sasa-static-key.secret_key
  sensitive = true
}

output "access_key_papa" {
  value     = yandex_iam_service_account_static_access_key.papa-static-key.access_key
  sensitive = false
}

output "secret_key_papa" {
  value     = yandex_iam_service_account_static_access_key.papa-static-key.secret_key
  sensitive = true
}


# terraform output -raw access_key
# terraform output -raw secret_key


output "internal_ip_address_sf-vm-1" {
  value = yandex_compute_instance.sf-vm-1.network_interface.0.ip_address
}

output "external_ip_address_sf-vm-1" {
  value = yandex_compute_instance.sf-vm-1.network_interface.0.nat_ip_address
}
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
output "internal_ip_address_vm_1" {
  value = module.module_instance_1.internal_ip_address_vm
}

output "external_ip_address_vm_1" {
  value = module.module_instance_1.external_ip_address_vm
}
output "internal_ip_address_vm_2" {
  value = module.module_instance_2.internal_ip_address_vm
}

output "external_ip_address_vm_2" {
  value = module.module_instance_2.external_ip_address_vm
}
