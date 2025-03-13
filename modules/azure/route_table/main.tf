# Crear una tabla de rutas en Azure
resource "azurerm_route_table" "azure_rt" {
  name                = "route-table-vpn"
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name           = "to-aws"
    address_prefix = "172.16.0.0/16"  # Rango de direcciones de la VPC en AWS
    next_hop_type  = "VirtualNetworkGateway"  # Puerta de enlace de VPN
  }
}

# Asociar la tabla de rutas con las subredes de la VNet
resource "azurerm_subnet_route_table_association" "subnet_rt_ass" {
  subnet_id      = var.public_subnet_ids[0]
  route_table_id = azurerm_route_table.azure_rt.id
}

