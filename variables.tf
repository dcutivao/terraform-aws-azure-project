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

variable "amis" {
  description = "Mapa de AMIs por región y sistema operativo"
  type        = map(map(string))
  default = {
    "us-east-1" = {
      "ubuntu"  = "ami-04b4f1a9cf54c11d0"
      "amazon"  = "ami-0c614dee691cbbf3"
      "windows" = "ami-04f77c9cd94746b09"
    }
    "us-west-2" = {
      "ubuntu"  = "ami-0cb91c7de36eed2cb"
      "amazon"  = "ami-018875e7376831abe"
      "windows" = "ami-01b4cce1dd306d1ee"
    }
  }
}

#-----------------------------------------------------------------------------------

variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}