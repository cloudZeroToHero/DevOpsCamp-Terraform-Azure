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
    virtual_machine {
      delete_os_disk_on_deletion     = true  # best setting for lab 
      graceful_shutdown              = false # request a graceful shutdown when the Virtual Machine is destroyed. Defaults to false.
      skip_shutdown_and_force_delete = false # this provides the ability to forcefully and immediately delete the VM and detach all sub-resources associated with the virtual machine. Defaults to false.
    }
  }
}

