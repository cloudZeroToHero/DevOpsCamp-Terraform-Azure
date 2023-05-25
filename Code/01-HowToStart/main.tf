terraform {
  required_version = ">=1.1.8"

  # HashiCorp "strongly recommends" including requires_providers block into production code
  # to block provider version and avoid problems when newest version could be incompatibile
  # with old one.
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" #this is shorthand for registry.terraform.io/hashicorp/azurerm
      version = "~> 3.1.0"          #this is the newest version as on 12.04.2022
    }
  }
}

provider "azurerm" {
  features {}
  # It is possible to pin/select subscripiotn here by providing its ID
  # subscription_id = "00000000-0000-0000-0000-000000000000"
  # tenant_id = "00000000-0000-0000-0000-000000000000"
}

resource "azurerm_resource_group" "DevOpsCamp-RG" {
  name     = "DevOpsCamp-RG"
  location = "westus"
  tags = {
    environment = "test"
  }
}