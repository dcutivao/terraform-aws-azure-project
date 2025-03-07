output "vm_network_interface" {
  value = azurerm_network_interface.nic-vm[0].id
}