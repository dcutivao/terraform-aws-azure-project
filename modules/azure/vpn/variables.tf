variable "owner" {
  description = "Propietario de los recursos desplegados"
  type        = string
}

variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "Nombre del grupo de recursos"
}

variable "location" {
  description = "Region desplegar recursos en Azure"
  type        = string
}

variable "gateway_address" {
  description = "Nombre de la conexión VPN de AWS"
  type        = string
}

variable "address_space" {
  description = "Lista de CIDR blocks para las subnets públicas"
  type        = list(string)
}

variable "subnet_id" {
  description = "ID de la subred a la que se conectará la VPN"
  type = string
}

variable "shared_key" {
  description = "Clave compartida para la autenticación de la VPN"
  type = string
}

variable "public_ip_address_id" {
  description = "Nombre de la IP pública de Azure"
  type        = string
}