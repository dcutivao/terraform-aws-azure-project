# Crear un Virtual Private Gateway (VGW) en AWS
resource "aws_vpn_gateway" "aws_vpn_gw" {
  vpc_id = var.vpc_id # Reemplaza con el ID de tu VPC en AWS
}

# Crear un Customer Gateway (CGW) en AWS
resource "aws_customer_gateway" "aws_cgw" {
  bgp_asn    = 65000                 # Número ASN (puede ser cualquier número privado)
  ip_address = var.azurerm_public_ip # IP pública de la puerta de enlace de Azure
  type       = "ipsec.1"
}

# Crear una conexión VPN en AWS
resource "aws_vpn_connection" "aws_vpn" {
  vpn_gateway_id      = aws_vpn_gateway.aws_vpn_gw.id
  customer_gateway_id = aws_customer_gateway.aws_cgw.id
  type                = "ipsec.1"
  static_routes_only  = true
}