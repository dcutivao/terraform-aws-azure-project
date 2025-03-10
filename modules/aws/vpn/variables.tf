variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "owner" {
  description = "Propietario de los recursos desplegados"
  type        = string
}

variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}

variable "azurerm_public_ip" {
  description = "Public IP de Azure"
}