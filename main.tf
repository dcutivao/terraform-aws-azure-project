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

module "ec2" {
  source               = "./aws/ec2"
  aws_region = var.aws_region
  os_type = var.os_type
  public_subnet_ids  = module.vpc.public_subnets
  private_subnet_ids = module.vpc.private_subnets
  environment = var.environment
  instance_type = var.instance_type
  subnet_type = var.subnet_type
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
