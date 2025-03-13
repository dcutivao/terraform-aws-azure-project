variable "location" {
  description = "Region desplegar recursos en Azure"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "Nombre del grupo de recursos"
}

variable "public_subnet_ids" {
  description = "Ids de subredes publicas"
  type        = list(string)
}