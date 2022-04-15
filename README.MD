## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.72.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_module_instance_1"></a> [module\_instance\_1](#module\_module\_instance\_1) | ./modules | n/a |
| <a name="module_module_instance_2"></a> [module\_instance\_2](#module\_module\_instance\_2) | ./modules | n/a |

## Resources

| Name | Type |
|------|------|
| yandex_compute_instance.sf-vm-1 | resource |
| yandex_iam_service_account.sasa | resource |
| yandex_iam_service_account_static_access_key.sasa-static-key | resource |
| yandex_resourcemanager_folder_iam_member.admin | resource |
| yandex_storage_bucket.test | resource |
| yandex_vpc_network.foo | resource |
| yandex_vpc_subnet.foo | resource |
| yandex_vpc_subnet.subnet1 | resource |
| yandex_vpc_subnet.subnet2 | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | n/a | `string` | `"b1gq09fegok6th6eku05"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | n/a | `string` | `"b1glq6vjtf2m7q3d569u"` | no |
| <a name="input_token"></a> [token](#input\_token) | n/a | `string` | `"AQAAAAAH5YqGAATuwVbU9LsB-UxbtNbbW1ALXCc"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | `"ru-central1-b"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key"></a> [access\_key](#output\_access\_key) | n/a |
| <a name="output_external_ip_address_sf-vm-1"></a> [external\_ip\_address\_sf-vm-1](#output\_external\_ip\_address\_sf-vm-1) | n/a |
| <a name="output_external_ip_address_vm_1"></a> [external\_ip\_address\_vm\_1](#output\_external\_ip\_address\_vm\_1) | n/a |
| <a name="output_external_ip_address_vm_2"></a> [external\_ip\_address\_vm\_2](#output\_external\_ip\_address\_vm\_2) | n/a |
| <a name="output_internal_ip_address_sf-vm-1"></a> [internal\_ip\_address\_sf-vm-1](#output\_internal\_ip\_address\_sf-vm-1) | n/a |
| <a name="output_internal_ip_address_vm_1"></a> [internal\_ip\_address\_vm\_1](#output\_internal\_ip\_address\_vm\_1) | !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! |
| <a name="output_internal_ip_address_vm_2"></a> [internal\_ip\_address\_vm\_2](#output\_internal\_ip\_address\_vm\_2) | n/a |
| <a name="output_secret_key"></a> [secret\_key](#output\_secret\_key) | n/a |
