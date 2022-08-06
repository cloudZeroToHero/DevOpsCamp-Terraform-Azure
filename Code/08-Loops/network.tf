
# Virtual Network
resource "azurerm_virtual_network" "Vnet" {
  name                = "vnet-${var.environment}-${var.az-region[var.environment]}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnet-addr[var.environment]

  tags = {
    environment = var.environment
  }
}

# Subnet
resource "azurerm_subnet" "SNet" {
  name                 = "snet-${var.environment}-${var.az-region[var.environment]}-01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = var.subnet[var.environment]

}


# Newrok interface
resource "azurerm_network_interface" "NIC" {
  name                = "nic-01-WEB-LVM"
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
  name                = "pip-web-${var.environment}-${var.az-region[var.environment]}-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# Network Security Group and rule
resource "azurerm_network_security_group" "SecGr" {
  name                = "nsg-web-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic security_rule {
    for_each = var.allowedPorts
    content {
      name                       = lookup(security_rule.value, "name")
      priority                   = lookup(security_rule.value, "priority") # range from 100 to 4096, lower nunber = higher priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = lookup(security_rule.value, "destPort")
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

}

# Connect the security group to subnet
resource "azurerm_subnet_network_security_group_association" "SGAssoc" {
  network_security_group_id = azurerm_network_security_group.SecGr.id
  subnet_id                 = azurerm_subnet.SNet.id
}