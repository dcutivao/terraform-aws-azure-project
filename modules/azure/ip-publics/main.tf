# Creación de ip publica
resource "azurerm_public_ip" "ip" {
  count               = var.vmcount
  name                = "ip-publica-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  allocation_method   = "Dynamic"
  tags = {
    "environment" = "entorno-${var.environment}"
    "owner"       = var.owner
  }
}

resource "azurerm_public_ip" "ip-vpn" {
  name                = "ip-public-vpn-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  allocation_method   = "Dynamic"
  tags = {
    "environment" = "entorno-${var.environment}"
    "owner"       = var.owner
  }
}
