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

variable "publisher" {
  description = "Nombre del proveedor de la imagen"
  type        = string
}
variable "offer" {
  description = "Nombre de la oferta de la imagen"
  type        = string
}
variable "sku" {
  description = "Especifica la versión o edición del sistema operativo"
  type        = string
}

variable "version" {
  description = "Versión de la imagen"
  type        = string
}