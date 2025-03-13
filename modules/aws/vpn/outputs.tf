output "aws_vpn_connection_key" {
  value = aws_vpn_connection.aws_vpn.tunnel1_preshared_key  # llave preestablecida para el túnel 1 (preshared key)
}

output "aws_vpn_connection_address" {
  value = aws_vpn_connection.aws_vpn.tunnel1_address   # Ip publica de AWS entregar proveedor
}

output "gateway_id" {
  value = aws_vpn_gateway.aws_vpn_gw.id
}