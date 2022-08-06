# Resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project-name}-${var.environment}-01"
  location = var.az-region[var.environment]
  tags = {
    environment = var.environment
  }
}



