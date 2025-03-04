output "azurerm_storage_account_id" {
  value = azurerm_storage_account.storage_account.id
}
output "azurerm_storage_account_storage_account" {
  value = azurerm_storage_account.storage_account.primary_blob_endpoint
}