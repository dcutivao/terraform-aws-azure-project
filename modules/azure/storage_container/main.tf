# Esto nos ayuda a crear el container para almacenamiento de objetos o archivos.
# usuamos el for_each para que itere sobre el array de variables y nos cree los contenedores deseados
resource "azurerm_storage_container" "container" {
  for_each              = toset(var.storage_container_name)
  name                  = each.value
  storage_account_id    = var.azurerm_storage_account_id #azurerm_storage_account.storage_account.id
  container_access_type = var.container_access_type                         # Puede ser private, blob o container
}