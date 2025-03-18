resource "azurerm_network_security_group" "nsg" {
  for_each = var.network_security_groups

  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

# Asociar SG a una Subnet
resource "azurerm_subnet_network_security_group_association" "sg-db-subnet" {
  subnet_id                 = var.subnet_id_db
  network_security_group_id = azurerm_network_security_group.nsg["nsg-mysql"].id
}

resource "azurerm_subnet_network_security_group_association" "sg-interface-private" {
  subnet_id                 = var.subnet_id_private[0]
  network_security_group_id = azurerm_network_security_group.nsg["nsg-vm-private"].id
}


# Asociar SG a una inteface
resource "azurerm_network_interface_security_group_association" "sg-interface-public" {
  network_interface_id      = var.vm_network_interface
  network_security_group_id = azurerm_network_security_group.nsg["nsg-vm-public"].id
}