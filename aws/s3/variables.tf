variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}

variable "acl" {
  description = "Control de acceso del bucket"
  type        = string
  default     = "private"
}

variable "force_destroy" {
  description = "Forzar la eliminación del bucket incluso si tiene contenido"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Etiquetas para el bucket S3"
  type        = map(string)
  default     = {}
}
