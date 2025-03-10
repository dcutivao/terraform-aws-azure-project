output "public_subnet_ids" {
  value = azurerm_subnet.public[*].id
}
output "private_subnet_ids" {
  value = azurerm_subnet.private[*].id
}

output "public_subnet_daco" {
  value = azurerm_subnet.gateway_subnet.id
}