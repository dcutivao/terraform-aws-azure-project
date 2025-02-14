output "rds_endpoint" {
  description = "Endpoint de la RDS"
  value       = aws_db_instance.rds.endpoint
}

output "rds_arn" {
  description = "ARN de la RDS"
  value       = aws_db_instance.rds.arn
}