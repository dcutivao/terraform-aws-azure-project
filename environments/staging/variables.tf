variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block para la VPC"
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
  type        = number
}

#--------------------------------------------------------------------------------

variable "amis" {
  description = "Mapa de AMIs por región y sistema operativo"
  type        = map(map(string))
  default = {
    "us-east-1" = {
      "ubuntu"  = "ami-04b4f1a9cf54c11d0"
      "amazon"  = "ami-085ad6ae776d8f09c"
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

#------------------------------------Variables compartidas entre nubes-----------------------------------------------------------------------------
variable "owner" {
  description = "Propietario de los recursos desplegados"
  type        = string
}

variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}
#------------------------------------Variables infra Azure--------------------------------------------------------
variable "location" {
  description = "Region desplegar recursos en Azure"
  type        = string
}
variable "id_suscripcion" {
  description = "id de la subcripcion de Azure"
  type        = string
}

variable "name_resource_group" {
  type        = string
  description = "Nombre del grupo de recursos"
}

variable "storage_container_name" {
  type    = list(string)
  default = []
}

variable "vmcount" {
  description = "numero de VMs a desplegar"
  type        = number
}

variable "account_tier" {
  description = "Nivel de cuenta de Azure Storage"
  type        = string
}

variable "account_replication_type" {
  description = "Tipo de replicacion de Azure Storage"
  type        = string
}

variable "container_access_type" {
  description = "Tipo de acceso a los contenedores de Azure Storage"
  type        = string
}

variable "address_space" {
  description = "CIRD Red virtual"
  type        = list(string)
}

variable "public_subnets" {
  description = "Lista de CIDR blocks para las subnets publicas"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}

variable "private_subnets" {
  description = "Lista de CIDR blocks para las subnets privadas"
  type = list(object({
    name           = string
    address_prefix = string
  }))
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

variable "administrator_login" {
  description = "Nombre de usuario del administrador de la base de datos Azure"
  type        = string
}

variable "administrator_password" {
  description = "Contraseña del administrador de la base de datos Azure"
  type        = string
}