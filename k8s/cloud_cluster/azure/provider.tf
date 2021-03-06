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
      resource_group_name = "#{YOUR_RG_FOR_TERRAFORM_BACKEND}#" # need to be static
      storage_account_name = "#{YOUR_STORAGE_ACCOUNT_NAME}#" # need to be static
      container_name = "terraform" # need to be static
      key = "tfstate/terraform.tfstate" # need to be static

      client_id = var.client_id
      client_secret = var.client_secret
      tenant_id = var.tenant_id
      subscription_id = var.subscription_id
  }

  required_version = "~> 1.0.9" # terraform required version

  required_providers {
    azurerm = {
      version = "~> 2.84.0" # azure rm provider required version
    }
  }
}