# Resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.project-name}-${var.environment}-RG"
  location = var.az-region[var.environment]
  tags = {
    environment = var.environment
  }
}

resource "tls_private_key" "SSHKey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

