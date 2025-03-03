variable "owner" {
  description = "Propietario de los recursos desplegados"
  type        = string
}

variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}

variable "vmcount" {
  description = "numero de VMs a desplegar"
  type        = number
}

variable "location" {
  description = "Region desplegar recursos en Azure"
  type        = string
}

variable "resource_group_name" {
  type = string
}