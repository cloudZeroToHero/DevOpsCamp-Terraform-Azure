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

# Newrok interface
resource "azurerm_network_interface" "NIC" {
  name                = "${var.project-name}-${var.environment}-NIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internalIP"
    subnet_id                     = azurerm_subnet.SNet.id
    private_ip_address_allocation = "Dynamic"
  }
}

