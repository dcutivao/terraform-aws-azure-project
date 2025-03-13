output "list_ip_public" {
  value = azurerm_public_ip.ip[*].id
}

output "ip_vpn" {
  value = azurerm_public_ip.ip-vpn.ip_address
}

output "id_vpn" {
  value = azurerm_public_ip.ip-vpn.id
}