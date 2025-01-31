# modules/security_group/outputs.tf
output "security_group_ids" {
  description = "IDs de los Security Groups creados"
  value       = { for sg in aws_security_group.sg : sg.name => sg.id }
}
