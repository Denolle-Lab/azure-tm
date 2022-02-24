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
    key                  = "fileshare-data.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# random names for resources
resource "random_pet" "acl" {
}
resource "random_pet" "storage-account" {
  length = 1
}
resource "random_string" "storage-account" {
  length  = 4
  upper   = false
  special = false
}

resource "azurerm_resource_group" "fileshare-data" {
  name     = "${terraform.workspace}-fileshare-data"
  location = var.location
}

# name can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long
# Storage account names must be unique across all Azure accounts!
resource "azurerm_storage_account" "fileshare-data" {
  name                     = "${random_pet.storage-account.id}${random_string.storage-account.id}"
  resource_group_name      = azurerm_resource_group.fileshare-data.name
  location                 = azurerm_resource_group.fileshare-data.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "fileshare-data" {
  name                 = random_pet.storage-account.id
  storage_account_name = azurerm_storage_account.fileshare-data.name
  quota                = var.disk_size

  # unique signed identifier of your choosing, up to 64 characters in length
  acl {
    id = random_pet.acl.id

    access_policy {
      permissions = "rwdl"
      # start       = "2019-07-02T09:38:21.0000000Z"
      # expiry      = "2019-07-02T10:38:21.0000000Z"
    }
  }
}
