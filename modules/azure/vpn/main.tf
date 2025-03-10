# Crear una IP pública para la puerta de enlace de VPN en Azure
resource "azurerm_public_ip" "azure_vpn_gw" {
  name                = "azure-vpn-gw-ip-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static" # "Static " o "Dynamic"
}

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
    public_ip_address_id          = azurerm_public_ip.azure_vpn_gw.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }
}

# Crear una conexión de red local en Azure
resource "azurerm_local_network_gateway" "azure_local_gw" {
  name                = "azure-local-gw-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  gateway_address     = var.aws_vpn_connection # IP pública del VPN Gateway en AWS
  address_space       = var.address_space      # Rango de direcciones de la VPC en AWS ["10.0.0.0/16"]
}

# Crear una conexión VPN en Azure
resource "azurerm_virtual_network_gateway_connection" "azure_vpn" {
  name                = "azure-vpn-connection-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.azure_vpn_gw.id
  local_network_gateway_id   = azurerm_local_network_gateway.azure_local_gw.id

  shared_key = var.aws_vpn_connection # Clave precompartida de AWS
}

#----------------------------------------------------------------

/* # Crear una red virtual en Azure
resource "azurerm_virtual_network" "azure_vnet" {
  name                = "azure-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = "East US" # Cambia a la región de tu VNet en Azure
  resource_group_name = azurerm_resource_group.example.name
}

# Crear una subred para la puerta de enlace de VPN en Azure
resource "azurerm_subnet" "azure_gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.azure_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
} */