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
    key                  = "test-fileshare.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "${var.name}-fileshare-resourcegroup"
  location = var.location
}

# name can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long
resource "azurerm_storage_account" "example" {
  name                     = var.name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "example" {
  name                 = var.name
  storage_account_name = azurerm_storage_account.example.name
  quota                = var.disk_size

  acl {
    id = "MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTI"

    access_policy {
      permissions = "rwdl"
      # start       = "2019-07-02T09:38:21.0000000Z"
      # expiry      = "2019-07-02T10:38:21.0000000Z"
    }
  }
}
