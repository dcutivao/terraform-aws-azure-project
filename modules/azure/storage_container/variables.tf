variable "storage_container_name" {
  type    = list(string)
}

variable "container_access_type" {
  description = "Tipo de acceso a los contenedores de Azure Storage"
  type = string
}

variable "azurerm_storage_account_id" {
  description = "Salida de ID de la cuenta de almacenamiento de Azure"
  type = string
}