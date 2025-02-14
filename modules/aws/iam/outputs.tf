output "iam_roles" {
  value = { for k, v in aws_iam_role.roles : k => v.name }
}

output "iam_instance_profiles" {
  value = { for k, v in aws_iam_instance_profile.instance_profiles : k => v.name }
}
