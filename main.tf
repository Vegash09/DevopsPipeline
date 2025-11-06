terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.112.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-rg-vsh"
    storage_account_name = "stgaccvegas"
    container_name       = "tfstatevsh"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "example" {
  name     = "Homes"
  location = "southeastasia"   # <-- change to allowed region
}

resource "azurerm_storage_account" "example" {
  name                     = "storefordatavegash"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}
