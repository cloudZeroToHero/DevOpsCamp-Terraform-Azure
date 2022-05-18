resource "azurerm_linux_virtual_machine" "LVM" {
  name                            = "${var.project-name}-${var.environment}-LVM"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_D2as_v5"
  disable_password_authentication = "true"
  admin_username                  = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.NIC.id,
  ]

  os_disk {
    name                 = "${var.project-name}-${var.environment}-OSDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/azurekey.pub")
  }

  custom_data = filebase64("custom_data.sh")

}