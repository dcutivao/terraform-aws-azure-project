variable "location" {
  description = "Region desplegar recursos en Azure"
  type        = string
}

variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}

variable "owner" {
  description = "Propietario de los recursos desplegados"
  type        = string
}

variable "name_resource_group" {
  type        = string
  description = "Nombre del grupo de recursos"
}

variable "account_tier" {
  description = "Nivel de cuenta de Azure Storage"
  type        = string
}

variable "account_replication_type" {
  description = "Tipo de replicacion de Azure Storage"
  type        = string
}