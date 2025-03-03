resource "aws_db_instance" "rds" {
  identifier             = var.db_identifier
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  instance_class         = var.db_instance_class
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  skip_final_snapshot    = true
  publicly_accessible    = var.publicly_accessible
  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  tags = {
    Name        = var.db_identifier
    environment = var.environment
  }
}

# Recurso como llama a la subnet en el main principal
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.db_identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "${var.db_identifier}-subnet-group"
    environment = var.environment
    Terraform   = "true"
  }
}