# Crear una tabla de rutas en AWS
resource "aws_route_table" "aws_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "10.0.0.0/16"  # Rango de direcciones de la VNet en Azure
    gateway_id = var.gateway_id  # Virtual Private Gateway
  }

  tags = {
    Name = "route-table-vpn"
    owner = var.owner
    environment = var.environment
  }
}

# Asociar la tabla de rutas con las subredes de la VPC
resource "aws_route_table_association" "aws_rt_ass" {
  subnet_id      = var.subnet_id[0]
  route_table_id = aws_route_table.aws_rt.id
}