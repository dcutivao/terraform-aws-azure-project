output "list_ip_public" {
  value = azurerm_public_ip.ip[*].id
}