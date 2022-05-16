# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project-name}-${var.environment}-VNet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.10.0.0/16"]

  tags = {
    environment = var.environment
  }
}

# Subnet
resource "azurerm_subnet" "SNet" {
  name                 = "${var.project-name}-${var.environment}-SNet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.10.1.0/24"]

}

