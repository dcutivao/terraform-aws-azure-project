variable "owner" {
  description = "Propietario de los recursos desplegados"
  type        = string
}

variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}

variable "vm_public_count" {
  description = "numero de VMs a desplegar"
  type        = number
}

variable "vm_private_count" {
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

variable "vm_version" {
  description = "Versión de la imagen"
  type        = string
}

variable "azurerm_storage_account_storage_account" {
  description = "Nombre del almacenamiento"
  type        = string
}

variable "public_subnet_ids" {
  description = "Ids de subredes publicas"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Ids de subredes privadas"
  type        = list(string)
}

variable "list_ip_public" {
  description = "Lista de ip publicas"
  type        = list(string)
}
