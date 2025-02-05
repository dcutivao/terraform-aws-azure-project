variable "db_identifier" {
  description = "Identificador de la base de datos"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "db_username" {
  description = "Usuario administrador de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña del usuario administrador"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Clase de la instancia RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Espacio en disco en GB"
  type        = number
  default     = 20
}

variable "engine" {
  description = "Motor de base de datos"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Versión del motor"
  type        = string
  default     = "8.0"
}

variable "subnet_ids" {
  description = "Lista de subnets privadas para la RDS"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Lista de Security Groups asignados a la RDS"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Definir si la base de datos es accesible públicamente"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}
