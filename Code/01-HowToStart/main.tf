terraform {
  required_version = ">=1.1.8"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" #this is shorthand for registry.terraform.io/hashicorp/azurerm
      version = "~> 3.1.0"          #this is the newest version as on 12.04.2022
    }
  }
}

provider "azurerm" {
  features {}
}



resource "azurerm_resource_group" "DevOpsCamp-RG" {
  name     = "DevOpsCamp-RG"
  location = "westeurope"
  tags = {
    environment = "test"
  }
}