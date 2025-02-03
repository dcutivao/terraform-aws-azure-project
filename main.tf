provider "aws" {
  region = var.aws_region
}

provider "azurerm" {
  features {}
}


module "vpc" {
  source               = "./aws/vpc"
  vpc_cidr             = var.vpc_cidr
  environment          = var.environment
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_az      = var.availability_az
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
}

module "security_groups" {
  source = "./aws/security_groups"
  vpc_id = module.vpc.vpc_id
  security_groups = [
    {
      name        = "ec2-sg"
      description = "Security Group para EC2"
      ingress_rules = [
        { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
      ]
      egress_rules = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
    },
    {
      name        = "rds-sg"
      description = "Security Group para RDS"
      ingress_rules = [
        { from_port = 5432, to_port = 5432, protocol = "tcp", cidr_blocks = ["10.0.0.0/16"] }
      ]
      egress_rules = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
    }
  ]
}

module "ec2" {
  source = "./aws/ec2"

  aws_region  = var.aws_region
  amis        = var.amis
  environment = var.environment
  instances = {
    "web-server" = {
      instance_type = "t2.micro"
      # Red a la que pertenecera public o private y la posicion según el indexado de la lista en el archivo terraform.tfvars
      subnet_id       = module.vpc.public_subnets[0]
      os              = "ubuntu"
      security_groups = [module.security_groups.security_group_ids["ec2-sg"], module.security_groups.security_group_ids["rds-sg"]]
    }
    "db-server" = {
      instance_type   = "t2.medium"
      subnet_id       = module.vpc.private_subnets[1] # esto es la salida del ouput de la variable private_subnets del modulo ec2
      os              = "amazon"
      security_groups = [module.security_groups.security_group_ids["rds-sg"]]
    }
  }
}


/* module "s3_bucket" {
  source        = "./aws/s3"
  bucket_name   = "prueba-123-my-example-bucket"
  acl           = "private"
  force_destroy = true
  tags = {
    Environment = "Dev"
    Project     = "Terraform AWS-Azure"
  }
} */
