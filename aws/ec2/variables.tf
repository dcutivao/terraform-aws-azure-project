variable "ami_map" {
  description = "Mapa de AMIs por región y tipo de sistema operativo"
  type = map(map(string))
  default = {
    "us-east-1" = {
      "linux"   = "ami-0ac4dfaf1c5c0cce9"
      "ubuntu"  = "ami-04b4f1a9cf54c11d0"
      "windows" = "ami-04f77c9cd94746b09"
    }
    "us-west-1" = {
      "linux"   = "ami-fedcba9876543210"
      "ubuntu"  = "ami-567890abcdef1234"
      "windows" = "ami-4321fedcba098765"
    }
  }
}

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
}
variable "os_type" {
  description = "Tipo de sistema operativo (linux, ubuntu, windows)"
  type        = string
}

variable "public_subnet_ids" {
  description = "Lista de IDs de subredes públicas"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subredes privadas"
  type        = list(string)
}

variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
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
locals {
  # Lógica para seleccionar la lista de subredes según el tipo
  selected_subnet_ids = var.subnet_type == "public" ? var.public_subnet_ids : var.private_subnet_ids
}