output "vpc_id" {
  value = module.vpc.vpc_id
}
output "bucket_arn" {
  value = module.s3_bucket.bucket_arn[*]
}

output "rds_endpoint" {
  description = "Enpoint conexion DB"
  value = module.rds.rds_endpoint
}