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
  kubernetes_version = "1.21.1"


  default_node_pool {
    name            = "default"
    node_count      = 3
    vm_size         = "Standard_B2s"
    os_disk_size_gb = 30
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
