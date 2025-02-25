output "name_resource_group" {
  value = azurerm_resource_group.rg.name
}

output "location" {
  value = azurerm_resource_group.rg.location
}

output "environment" {
  value = azurerm_resource_group.rg.tags.environment
}

output "owner" {
  value = azurerm_resource_group.rg.tags.owner
}