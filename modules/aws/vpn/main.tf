# Crear un Virtual Private Gateway (VGW) en AWS
resource "aws_vpn_gateway" "aws_vpn_gw" {
  vpc_id = var.vpc_id # Reemplaza con el ID de tu VPC en AWS
  tags = {
    Name = "aws_vpn_gw-${var.environment}"
  }
}

# Crear un Customer Gateway (CGW) en AWS
resource "aws_customer_gateway" "aws_cgw" {
  bgp_asn    = 65000                 # Número ASN (puede ser cualquier número privado)
  ip_address = var.azurerm_public_ip # IP pública de la puerta de enlace de Azure
  type       = "ipsec.1"
  tags = {
    Name = "Customer Gateway-${var.environment}"
  }
}

# Crear una conexión VPN en AWS
resource "aws_vpn_connection" "aws_vpn" {
  vpn_gateway_id      = aws_vpn_gateway.aws_vpn_gw.id
  customer_gateway_id = aws_customer_gateway.aws_cgw.id
  type                = "ipsec.1"
  static_routes_only  = true

  tunnel1_inside_cidr   = "169.254.21.0/30"   # direcciones link-local según el estándar RFC 3927 comunicacion entre los dos VPN no es publica
  tags = {
    Name = "VPN-Connection-${var.environment}"
  }
}

resource "aws_vpn_connection_route" "azure_route" {
  destination_cidr_block = "10.0.7.0/24" # Subred de Azure
  vpn_connection_id      = aws_vpn_connection.aws_vpn.id
}