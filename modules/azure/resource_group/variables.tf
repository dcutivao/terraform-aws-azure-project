variable "name_resource_group" {
  type        = string
  description = "Nombre del grupo de recursos"
}

variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}

variable "location" {
  description = "Region desplegar recursos en Azure"
  type        = string
}

variable "owner" {
  description = "Propietario de los recursos desplegados"
  type = string
}