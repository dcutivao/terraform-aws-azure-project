output "vm_network_interface_public" {
  value = azurerm_network_interface.nic-vm-public[0].id
}