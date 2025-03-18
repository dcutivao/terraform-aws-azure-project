resource "aws_instance" "ec2" {
  for_each               = var.instances
  ami                    = var.amis[var.aws_region][each.value.os]
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = each.value.security_groups
  iam_instance_profile   = each.value.iam_instance_profile
  key_name               = each.value.key_name

  tags = {
    Name        = "${each.key}-${var.environment}"
    environment = var.environment
    Terraform   = "true"
  }
}