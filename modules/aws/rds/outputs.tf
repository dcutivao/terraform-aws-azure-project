output "rds_endpoint" {
  description = "Endpoint de la RDS"
  value       = aws_db_instance.rds.endpoint
}

output "rds_arn" {
  description = "ARN de la RDS"
  value       = aws_db_instance.rds.arn
}

output "rds_database_name" {
  description = "El nombre de la base de datos creada en RDS"
  value       = aws_db_instance.rds.db_name
}

output "rds_username" {
  description = "El nombre de usuario maestro de la base de datos"
  value       = aws_db_instance.rds.username
  #sensitive   = true # Marca este output como sensible para no exponerlo en los logs
}