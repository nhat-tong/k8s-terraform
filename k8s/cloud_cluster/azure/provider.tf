provider "azurerm" {
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id
    subscription_id = var.subscription_id
    
    features {}
    skip_provider_registration = "true"
}

terraform {
  backend "azurerm" {
      resource_group_name = "terraform" # need to be static
      storage_account_name = "backendsto2021" 
      container_name = "terraform"
      key = "tfstate/terraform.tfstate"

      client_id = var.client_id
      client_secret = var.client_secret
      tenant_id = var.tenant_id
      subscription_id = var.subscription_id
  }

  required_version = "~> 1.0.9"

  required_providers {
    azurerm = {
      version = "~> 2.84.0"
    }
  }
}