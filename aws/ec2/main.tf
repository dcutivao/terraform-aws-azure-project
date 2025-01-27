resource "aws_instance" "server_web" {
  ami           = lookup(lookup(var.ami_map, var.aws_region, {}), var.os_type, "")
  instance_type = var.instance_type
  subnet_id     = local.selected_subnet_ids[0]
  tags = {
    Name = "Server-${var.environment}"
  }
}