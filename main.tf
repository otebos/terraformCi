
terraform {
  required_version = ">=1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.43.0"
    }
  }

  cloud {
    organization = "bartoszstrutynski"

    workspaces {
      name = "terraformCI"
    }
  }
}

provider "azurerm" {
  features {}

  skip_provider_registration = true
}

resource "random_string" "uniquestring" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "811-59d6f40e-provide-continuous-delivery-with-gith"
  location = "East US"
}

resource "azurerm_storage_account" "storage" {
  name                     = "strgbsts2436587"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
