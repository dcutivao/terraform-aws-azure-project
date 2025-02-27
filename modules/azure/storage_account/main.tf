# Esto nos srive para crear el nombre random de la cuenta de almacenamiento
resource "random_string" "storageaccount-name" {
  length  = 16
  special = false
  upper   = false
}

# Esto nos ayuda a construir la cuenta de almacenamiento
resource "azurerm_storage_account" "storage_account" {
  name                     = random_string.storageaccount-name.result       #no acepta numeros, matusculas ni caracteres especiales, maximo 24 caracteres.
  resource_group_name      = var.name_resource_group
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags = {
    environment = "entorno-${var.environment}"
    owner       = var.owner
  }
}

