provider "aws" {
  #region = var.aws_region
}

provider "azurerm" {
  features {}
}

module "aws_infra" {
  source = "./aws"
}

module "azure_infra" {
  source = "./azure"
}

module "vpn" {
  source = "./vpn"
  #aws_vpc_id = module.aws_infra.vpc_id
  #azure_vnet_id = module.azure_infra.vnet_id
}