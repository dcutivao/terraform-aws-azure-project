variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  description = "Region desplegar recursos en Azure"
  type        = string
}

variable "owner" {
  description = "Propietario de los recursos desplegados"
  type        = string
}

variable "administrator_login" {
  description = "Nombre de usuario del administrador de la base de datos Azure"
  type        = string
}

variable "administrator_password" {
  description = "Contraseña del administrador de la base de datos Azure"
  type        = string
}

variable "delegated_subnet_id" {
  description = "ID de la subred a la que se conectará el recurso"
}