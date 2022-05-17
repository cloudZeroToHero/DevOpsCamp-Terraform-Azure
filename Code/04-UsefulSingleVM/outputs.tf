# VM public IP
output "public_ip_address" {
  value       = azurerm_linux_virtual_machine.LVM.public_ip_address
  description = "Open this IP in a web browser to see your web page"
}

