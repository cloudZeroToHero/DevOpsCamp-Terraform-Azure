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
    public_ip_address_id          = azurerm_public_ip.PublicIP.id
  }
}

# VM Public IP
resource "azurerm_public_ip" "PublicIP" {
  name                = "${var.project-name}-${var.environment}-PubIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# Network Security Group and rule
resource "azurerm_network_security_group" "SecGr" {
  name                = "${var.project-name}-${var.environment}-SecGR"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 150 # range from 100 to 4096, lower nunber = higher priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "WEB"
    priority                   = 151 # range from 100 to 4096, lower nunber = higher priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "SecGrAssoc" {
  network_interface_id      = azurerm_network_interface.NIC.id
  network_security_group_id = azurerm_network_security_group.SecGr.id
}