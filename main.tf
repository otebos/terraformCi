
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
  name     = "811-b846599d-provide-continuous-delivery-with-gith"
  location = "South Central US"
}

resource "azurerm_storage_account" "storage" {
  name                     = "strgbsts${random_string.uniquestring.result}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
