output "vpc_id" {
  value = module.vpc.vpc_id
}

output "iam_instance_profile" {
  value = module.iam.iam_instance_profiles[*]
}
output "bucket_arn" {
  value = module.s3_bucket.bucket_arn[*]
}