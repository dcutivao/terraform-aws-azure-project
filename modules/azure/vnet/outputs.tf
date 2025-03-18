output "public_subnet_ids" {
  value = azurerm_subnet.public[*].id
}
output "private_subnet_ids" {
  value = azurerm_subnet.private[*].id
}

output "gateway_subnet" {
  value = azurerm_subnet.gateway_subnet.id
}

output "db_subnet" {
  value = azurerm_subnet.db_subnet.id
}