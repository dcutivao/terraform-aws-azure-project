variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
}

variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de CIDR blocks para las subnets públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDR blocks para las subnets privadas"
  type        = list(string)
}

variable "public_subnet_count" {
  description = "Número de subnets públicas"
  type        = number
}

variable "private_subnet_count" {
  description = "Número de subnets privadas"
  type        = number
}

variable "availability_az" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)
}