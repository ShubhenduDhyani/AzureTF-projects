terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg-cicd"
    storage_account_name = "tftestbackend2025sd"
    container_name      = "tfstateme"
    key                 = "tst.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = "470d625a-0c4c-4357-a1ee-c6210571c599"
}