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
      name         = "ec2-sg"
      description  = "Security Group para EC2"
      ingress_rules = [
        { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
      ]
      egress_rules = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
    },
    {
      name         = "rds-sg"
      description  = "Security Group para RDS"
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
  source             = "./aws/ec2"
  aws_region         = var.aws_region
  os_type            = var.os_type
  public_subnet_ids  = module.vpc.public_subnets
  private_subnet_ids = module.vpc.private_subnets
  environment        = var.environment
  instance_type      = var.instance_type
  subnet_type        = var.subnet_type
  position_red       = var.position_red
  security_group_ids = [module.security_groups.security_group_ids.ec2-sg]
  vpc_id             = module.vpc.vpc_id
}

/* module "aws_infra" {
  source = "./aws"
}

module "azure_infra" {
  source = "./azure"
}

module "vpn" {
  source = "./vpn"

  #aws_vpc_id = module.aws_infra.vpc_id
  #azure_vnet_id = module.azure_infra.vnet_id
}*/

#Retrieve the list of AZs in the current AWS region
/* data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = var.vpc_name
    Environment = "demo_environment"
    Terraform   = "true"
  }
} */


#Deploy the private subnets
/* resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]

  tags = {
    Name      = each.key
    Terraform = "true"
  }
}

#Deploy the public subnets
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  availability_zone       = tolist(data.aws_availability_zones.available.names)[each.value]
  map_public_ip_on_launch = true

  tags = {
    Name      = each.key
    Terraform = "true"
  }
} */

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
