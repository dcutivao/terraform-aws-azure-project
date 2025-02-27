variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}

variable "location" {
  description = "Region desplegar recursos en Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "address_space" {
  description = "CIRD Red virtual"
  type = list(string)
}

variable "public_subnets" {
  description = "Lista de CIDR blocks para las subnets publicas"
  type = list(string)
}

variable "private_subnets" {
  description = "Lista de CIDR blocks para las subnets privadas"
  type = list(string)
}