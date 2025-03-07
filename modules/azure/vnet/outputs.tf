output "public_subnet_ids_0" {
  value = azurerm_subnet.public[0].id
}

output "public_subnet_ids_1" {
  value = azurerm_subnet.public[1].id
}
output "private_subnet_ids_0" {
  value = azurerm_subnet.private[0].id
}
output "private_subnet_ids_1" {
  value = azurerm_subnet.private[1].id
}

output "public_subnet_ids" {
  value = azurerm_subnet.public[*].id
}
output "private_subnet_ids" {
  value = azurerm_subnet.private[*].id
}