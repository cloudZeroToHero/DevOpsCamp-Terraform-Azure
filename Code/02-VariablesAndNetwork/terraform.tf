#newest version availabe on 12.05.2022
terraform {
  required_version = ">=1.1.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" #this is shorthand for registry.terraform.io/hashicorp/azurerm
      version = "~> 3.5.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

