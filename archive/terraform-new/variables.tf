variable "folder_id" {
  #description = "my folder_id yandex provider"
  type    = string
  default = "b1ghb1lptk8qjdn5qa8j"
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

variable "zone" {
  description = "Use specific availability zone."
  type        = list(string)
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
}

