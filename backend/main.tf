terraform {

  required_version = ">=1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstate5063"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }

}

provider "azurerm" {
features {}
}

resource "azurerm_resource_group" "terraform-state" {
name     = "terraform-state"
location = "westus2"
}
