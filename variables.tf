variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
}

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

variable "availability_az" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)
}

variable "public_subnet_count" {
  description = "Número de subnets públicas"
  type        = number
}

variable "private_subnet_count" {
  description = "Número de subnets privadas"
}

#--------------------------------------------------------------------------------
variable "os_type" {
  description = "Tipo de sistema operativo (linux, ubuntu, windows)"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia"
  type        = string
}
variable "subnet_type" {
  description = "Tipo de subred a utilizar (public o private)"
  type        = string
}
variable "position_red" {
  description = "Tipo de subred a utilizar (public o private)"
  type        = number
}