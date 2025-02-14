variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}
variable "status_versioning" {
  description = "habilitar versionamiento de objetos en el bucket S3"
  type = string
}
variable "server_side_encryption_configuration" {
  description = "Configuración para encriptación en reposo"
  type        = any
  default     = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}
variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}