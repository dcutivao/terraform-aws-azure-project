# Crear una puerta de enlace de VPN en Azure
resource "azurerm_virtual_network_gateway" "azure_vpn_gw" {
  name                = "azure-vpn-gw-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig-${var.environment}"
    public_ip_address_id          = var.public_ip_address_id    # Ip publica creada en azure
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }

  tags = {
    Name = "azure-vpn-gw-${var.environment}"
  }
}

# Crear una conexión de red local en Azure
resource "azurerm_local_network_gateway" "azure_local_gw" {
  name                = "azure-local-gw-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  gateway_address     = var.gateway_address     # IP pública del VPN Gateway en AWS
  address_space       = ["172.16.3.0/24"] #var.address_space   # Rango de direcciones de la VPC en AWS ["10.0.0.0/16"]
}

# Crear una conexión VPN en Azure
resource "azurerm_virtual_network_gateway_connection" "azure_vpn" {
  name                = "azure-vpn-connection-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.azure_vpn_gw.id
  local_network_gateway_id   = azurerm_local_network_gateway.azure_local_gw.id

  shared_key = var.shared_key # Clave precompartida de AWS
}