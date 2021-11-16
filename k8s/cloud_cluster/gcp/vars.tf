variable "project_id" {}

variable "region" {}

variable "network_cidr" {
  default = "10.2.0.0/24"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}