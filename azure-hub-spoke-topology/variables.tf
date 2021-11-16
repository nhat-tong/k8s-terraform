## Variables declarations

variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

variable "backend_storage_account" {
    default = "backend-rg"
}

variable "backend_resource_group" {
    default = "mybackendstorage"
}

variable "resource_group_name" {
    default = "hub-spoke-rg"
}

variable "resource_group_location" {
    default = "France Central"
}

variable "hub_vnet_name" {
    default = "hub-vnet"
}

variable "hub_location" {
    default = "France Central"
}

variable "hub_nsg_name" {
    default = "hub-nsg"
}

variable "source_address_hub" {}

variable "hub_subnet_name" {
    default = "hub-subnet"
}

variable "spoke1_vnet_name" {
    default = "finance-spoke-vnet"
}

variable "spoke1_location" {
    default = "West Europe"
}

variable "spoke1_nsg_name" {
    default = "finance-nsg"
}

variable "spoke1_subnet_name" {
    default = "finance-subnet"
}

variable "source_address_spoke1_authorized" {
    default = "10.22.0.0/27"
}

variable "spoke2_vnet_name" {
    default = "it-spoke-vnet"
}

variable "spoke2_nsg_name" {
    default = "it-nsg"
}

variable "spoke2_location" {
    default = "North Europe"
}

variable "source_address_spoke2_authorized" {
    default = "10.22.0.0/27"
}

variable "spoke2_subnet_name" {
    default = "it-subnet"
}

variable "vm_size" {
    default = "Standard_B1s"
}

variable "vm_publisher" {
    default = "Canonical"
}

variable "vm_offer" {
    default = "UbuntuServer"
}

variable "vm_sku" {
    default = "18.04-LTS"
}

variable "vm_version" {
    default = "latest"
}

variable "vm_public_key" {}
variable "vm_admin_password" {}

variable "proxyout_vnet_name" {
  default = "proxyout-vnet"
}

variable "proxyout_location" {
  default = "France Central"
}

variable "proxyout_nsg_name" {
  default = "proxyout-nsg"
}

variable "proxyout_subnet_name" {
  default = "proxyout-subnet"
}

variable "france_central_boot_diagnostics_uri" {}
variable "west_europe_boot_diagnostics_uri" {}
variable "north_europe_boot_diagnostics_uri" {}