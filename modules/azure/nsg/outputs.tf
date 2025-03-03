output "network_security_group_ids" {
  description = "IDs de los Network Security Groups creados"
  value = {
    for name, nsg in azurerm_network_security_group.nsg : name => nsg.id
  }
}
