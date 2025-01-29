module "security_groups" {
  source = "../security_groups"
}

resource "aws_instance" "server_web" {
  ami           = lookup(lookup(var.ami_map, var.aws_region, {}), var.os_type, "")
  instance_type = var.instance_type
  subnet_id     = local.selected_subnet_ids[var.position_red]
  #vpc_security_group_ids = [sg_server_web.id]
  tags = {
    Name = "Server-${var.environment}"
    Terraform = "true"
  }
}