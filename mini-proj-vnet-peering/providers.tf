terraform {
  required_providers {
    azurerm={
        source = "hashicorp/azurerm"
        version = "~> 4.8.0"
    }
  }
  required_version = ">= 1.9.0"
}
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "470d625a-0c4c-4357-a1ee-c6210571c599"
  tenant_id = "ec8fc4f9-0270-465a-a3f8-f526a464d2e6"
}