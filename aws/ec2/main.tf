resource "aws_instance" "ec2" {
  for_each      = var.instances
  ami           = var.amis[var.aws_region][each.value.os]
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id
  vpc_security_group_ids = each.value.security_groups

  tags = {
    environment = var.environment
    Terraform   = "true"
  }
}