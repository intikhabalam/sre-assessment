terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.93.1"
    }
  }
}

provider "azurerm" {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.93.1"
    }
   features {}
}
