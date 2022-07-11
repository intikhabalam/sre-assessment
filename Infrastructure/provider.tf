terraform {
provider "azurerm" {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.93.1"
    }
   features {}
    }
}

