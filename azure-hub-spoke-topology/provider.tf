provider "azurerm" {
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id
    subscription_id = var.subscription_id

    version = "= 2.39.0"
    features {}
    skip_provider_registration = "true"
}

terraform {
    backend "azurerm" {
        resource_group_name = "backend-rg"
        storage_account_name = "mybackendstorage"
        container_name = "terraform-state"
        key = "terraform/terraform.tfstate"
        client_id = var.client_id
        client_secret = var.client_secret
        tenant_id = var.tenant_id
        subscription_id = var.subscription_id
    }
    required_version = "= 0.12.24"
}