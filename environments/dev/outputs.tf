/* output "vpc_id" {
  value = module.vpc.vpc_id
}
output "bucket_arn" {
  value = module.s3_bucket.bucket_arn[*]
}

output "rds_endpoint" {
  description = "Enpoint conexion DB"
  value = module.rds.rds_endpoint
} */

/* output "public_ip_address" {
  value = azurerm_public_ip.ip[*].ip_address
} */

output "location" {
  value = module.resource_group.location
}

output "environment" {
  value = module.resource_group.environment
}

output "owner" {
  value = module.resource_group.owner
}