variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}

variable "owner" {
  description = "Propietario de los recursos desplegados"
  type        = string
}

variable "subnet_id_private" {
  description = "ID de la subred a la que se conectará el recurso"
}

variable "vm_network_interface" {
  description = "ID de la interfaz de red de Azure"
  type        = string
}

variable "subnet_id_db" {
  description = "ID de la subred a la que se conectará la base de datos"
  type = string
}

variable "network_security_groups" {
  type = map(object({
    location            = string
    resource_group_name = string
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}