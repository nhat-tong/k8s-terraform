# service principal
variable "client_id" {}

variable "client_secret" {}

variable "tenant_id" {}

variable "subscription_id" {}

# aks cluster

variable "aks_rg" {}
variable "location" {
  default = "west europe"
}