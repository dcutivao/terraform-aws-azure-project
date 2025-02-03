variable "instances" {
  description = "Lista de instancias a crear"
  type = map(object({
    instance_type   = string
    subnet_id       = string
    os              = string
    security_groups = list(string)
  }))
}

variable "aws_region" {
  description = "Región donde se lanzarán las instancias"
  type        = string
}

variable "amis" {
  description = "Mapa de AMIs por región y sistema operativo"
  type        = map(map(string))
}

variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}
