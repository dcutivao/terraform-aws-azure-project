# Esto nos sirve para crear el grupo de recurso
resource "azurerm_resource_group" "rg" {
  name     = "${var.name_resource_group}-${var.environment}"
  location = var.location
  tags = {
    environment = "entorno-${var.environment}"
    owner       = var.owner
  }
}