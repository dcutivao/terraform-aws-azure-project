# Creación de Red virtual vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "VirtualNetwor-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
   tags = {
    "environment" = "entorno-${var.environment}"
  }
}

resource "azurerm_subnet" "public" {
  count                = length(var.public_subnets)
  name                 = var.public_subnets[count.index].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.public_subnets[count.index].cidr]
}

resource "azurerm_subnet" "private" {
  count                = length(var.private_subnets)
  name                 = var.private_subnets[count.index].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_subnets[count.index].cidr]
}


/* resource "azurerm_virtual_network" "vpc" {
  resource_group_name = azurerm_resource_group.rg.name 
 

#creacion de subnet
resource "azurerm_subnet" "mysubnet" {
  name                 = "misubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vpc.name
  address_prefixes     = ["10.0.1.0/24"]
}*/