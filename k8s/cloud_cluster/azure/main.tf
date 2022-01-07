resource "azurerm_resource_group" "rg" {
    name            = var.aks_rg
    location        = var.location
}

resource "random_pet" "prefix" {}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${random_pet.prefix.id}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${random_pet.prefix.id}-k8s"
  kubernetes_version = var.aks_version


  default_node_pool {
    name            = "default"
    node_count      = var.node_count
    vm_size         = var.node_vm_size
    os_disk_size_gb = var.node_os_disk
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  linux_profile {
    admin_username = "cicd"
    ssh_key {
        key_data = file("secret/id_rsa.pub")
    }
  }
}