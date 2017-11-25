# Settings

variable "account" {
  default = "pckr"
}

variable "dns_prefix" {
  default = "pckr"
}

variable "location" {
  default = "westeurope"
}

variable "azure_dns_suffix" {
    description = "Azure DNS suffix for the Public IP"
    default = "cloudapp.azure.com"
}

variable "admin_username" {
  default = "vagrant"
}

variable "admin_password" {
  default = "Password1234!"
}

variable "count" {
  default = 1
}

variable "vm_size" {
  default = "Standard_E2s_v3"
}
