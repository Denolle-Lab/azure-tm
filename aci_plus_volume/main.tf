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
    key                  = "seisbench-container-volume.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Get key to access existing Azure File Share
data "azurerm_storage_account" "example" {
  name                = var.file_share_storage_account
  resource_group_name = var.file_share_resource_group
}

resource "random_id" "token" {
  byte_length = 32
}

resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_container_group" "example" {
  name                = "${var.prefix}-container"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  ip_address_type     = "public"
  dns_name_label      = var.prefix
  os_type             = "linux"

  container {
    name   = "hw"
    image  = var.image
    cpu    = var.cpu
    memory = var.ram

    environment_variables = {
      JUPYTER_TOKEN = random_id.token.hex
    }

    # https://docs.microsoft.com/en-us/azure/container-instances/container-instances-volume-azure-files#get-storage-credentials
    volume {
      name       = "home"
      mount_path = "/home/jovyan"
      read_only  = false

      share_name = var.file_share_name
      storage_account_name = var.file_share_storage_account
      storage_account_key  = data.azurerm_storage_account.example.primary_access_key
    }

    ports {
      port     = 8888
      protocol = "TCP"
    }
  }

}

output "jupyterlab_url" {
  value = "${azurerm_container_group.example.fqdn}:8888/lab?token=${random_id.token.hex}"
}
