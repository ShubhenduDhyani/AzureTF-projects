terraform {
  backend "azurerm" {
    resource_group_name = "tf-stg-rg"
    storage_account_name = "tfstateremotebackendstg"
    container_name = "remotebckend"
    key = "prod.terraform.tfstate"
  }
}