# service principal
variable "client_id" {}

variable "client_secret" {}

variable "tenant_id" {}

variable "subscription_id" {}

# aks cluster

variable "aks_rg" {
  default = "cluster-aks"
}

variable "aks_version" {
  default = "1.21.1"
}

variable "location" {
  default = "west europe"
}

variable "node_count" {
  default = 3
}

variable "node_vm_size" {
  default = "Standard_B2s"
}

variable "node_os_disk" {
  default = 30
}

variable "vm_admin_username" {
  default = "cicd"
}