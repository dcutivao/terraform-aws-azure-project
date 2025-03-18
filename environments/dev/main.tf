#-----------------------------------Infraestrucutura AWS--------------------------------------------------------
module "vpc" {
  source               = "../../modules/aws/vpc"
  vpc_cidr             = var.vpc_cidr
  environment          = var.environment
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_az      = var.availability_az
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
}

module "security_groups" {
  source = "../../modules/aws/security_groups"
  vpc_id = module.vpc.vpc_id
  security_groups = [
    {
      name        = "ec2-sg"
      description = "Security Group para EC2"
      ingress_rules = [
        { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = -1, to_port = -1, protocol = "icmp", cidr_blocks = ["0.0.0.0/0"] }
      ]
      egress_rules = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
    },
    {
      name        = "rds-sg"
      description = "Security Group para RDS"
      ingress_rules = [
        { from_port = 3306, to_port = 3306, protocol = "tcp", cidr_blocks = ["172.16.3.0/24"] }
      ]
      egress_rules = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
    }
  ]
}

module "iam" {
  source = "../../modules/aws/iam"

  iam_roles = {
    "EC2Role" = {
      service                 = "ec2.amazonaws.com"
      policy_file             = "ec2_policy.json"
      effect                  = "Allow"
      action                  = ["s3:ListBucket", "s3:GetObject"]
      resource                = [module.s3_bucket.bucket_arn, "${module.s3_bucket.bucket_arn}/*"]
      create_instance_profile = true
    }
    # Dejo como ejemplo para futuros cambios anexar politicas de acceso a los roles como lambda y S3
    /* "LambdaRole" = {
      service               = "lambda.amazonaws.com"
      policy_file           = "lambda_policy.json"
      effect                = "Allow"
      Action                = ["dynamodb:PutItem", "dynamodb:GetItem"]
      "Resource"            = ["*"]
    }  
    "S3Role" = {
      service               = "s3.amazonaws.com"
      policy_file           = "s3_policy.json"
    }*/
  }
}

module "keys" {
  source      = "../../modules/key"
  environment = var.environment
}
module "ec2" {
  source = "../../modules/aws/ec2"

  aws_region  = var.aws_region
  amis        = var.amis
  environment = var.environment
  instances = {
    "web-server" = {
      instance_type        = "t2.micro"
      subnet_id            = module.vpc.public_subnets[1]
      os                   = "amazon"
      security_groups      = [module.security_groups.security_group_ids["ec2-sg"]]
      iam_instance_profile = module.iam.iam_instance_profiles["EC2Role"]
      key_name             = module.keys.aws_key_pair #aws_key_pair.generated.key_name
    }
    "db-server" = {
      instance_type        = "t2.micro"
      subnet_id            = module.vpc.private_subnets[0] # esto es la salida del ouput de la variable private_subnets del modulo ec2
      os                   = "ubuntu"
      security_groups      = [module.security_groups.security_group_ids["rds-sg"], module.security_groups.security_group_ids["ec2-sg"]]
      iam_instance_profile = module.iam.iam_instance_profiles["EC2Role"]
      key_name             = module.keys.aws_key_pair
    }
  }
}

/* module "rds" {
  source             = "../../modules/aws/rds"
  db_identifier      = "db-${var.environment}"
  db_name            = "mydb${var.environment}"
  db_username        = "admin"
  db_password        = "Pueden_Copiar_el_Password123"
  db_instance_class  = "db.t4g.micro"
  allocated_storage  = 20
  engine             = "mysql"
  engine_version     = "8.0"
  subnet_ids         = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  security_group_ids = [module.security_groups.security_group_ids["rds-sg"]]
  environment        = var.environment
} */

module "s3_bucket" {
  source            = "../../modules/aws/s3"
  bucket_name       = var.bucket_name
  status_versioning = "Disabled" # habilitar use Enabled
  environment       = var.environment
}

module "vpn-aws" {
  source            = "../../modules/aws/vpn"
  vpc_id            = module.vpc.vpc_id
  azurerm_public_ip = module.ip_publis.ip_vpn
  environment       = var.environment
  owner             = var.owner
}

/* module "aws_route_table" {
  source      = "../../modules/aws/route_table"
  gateway_id  = module.vpn-aws.gateway_id
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
  owner       = var.owner
  subnet_id   = module.vpc.public_subnets
} */

#-----------------------------------Infraestrucutura Azure--------------------------------------------------------

module "resource_group" {
  source = "../../modules/azure/resource_group"

  name_resource_group = var.name_resource_group
  location            = var.location
  environment         = var.environment
  owner               = var.owner
}

module "storage_account" {
  source = "../../modules/azure/storage_account"

  account_replication_type = var.account_replication_type
  name_resource_group      = module.resource_group.name_resource_group
  environment              = module.resource_group.environment
  location                 = module.resource_group.location
  owner                    = module.resource_group.owner
  account_tier             = var.account_tier
}

module "storage_container" {
  source                     = "../../modules/azure/storage_container"
  storage_container_name     = var.storage_container_name
  container_access_type      = var.container_access_type
  azurerm_storage_account_id = module.storage_account.azurerm_storage_account_id # ejemplo de llamar un modulo a otro
}

module "vnet" {
  source              = "../../modules/azure/vnet"
  location            = var.location
  resource_group_name = module.resource_group.name_resource_group
  address_space       = var.address_space
  environment         = var.environment
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
}

module "nsg" {
  source               = "../../modules/azure/nsg"
  environment          = var.environment
  owner                = var.owner
  subnet_id_private    = module.vnet.private_subnet_ids
  subnet_id_db         = module.vnet.db_subnet
  vm_network_interface = module.vm.vm_network_interface_public
  network_security_groups = {
    "nsg-vm-public" = {
      location            = var.location
      resource_group_name = module.resource_group.name_resource_group
      security_rules = [
        {
          name                       = "AllowSSH"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowHTTP"
          priority                   = 200
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    },
    "nsg-mysql" = {
      location            = var.location
      resource_group_name = module.resource_group.name_resource_group
      security_rules = [
        {
          name                       = "AllowRDP"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "3306"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    },
    "nsg-vm-private" = {
      location            = var.location
      resource_group_name = module.resource_group.name_resource_group
      security_rules = [
        {
          name                       = "AllowSSH"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "AlloICMP"
          priority                   = 101
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Icmp"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
    
  }
}

module "ip_publis" {
  source              = "../../modules/azure/ip-publics"
  resource_group_name = module.resource_group.name_resource_group
  vmcount             = var.vm_public_count
  location            = var.location
  environment         = var.environment
  owner               = var.owner
}

module "vm" {
  source                                  = "../../modules/azure/vm"
  vm_private_count                        = var.vm_private_count
  vm_public_count                        = var.vm_public_count
  location                                = var.location
  resource_group_name                     = module.resource_group.name_resource_group
  environment                             = var.environment
  owner                                   = var.owner
  publisher                               = var.publisher
  offer                                   = var.offer
  sku                                     = var.sku
  vm_version                              = var.vm_version
  list_ip_public                          = module.ip_publis.list_ip_public
  public_subnet_ids                       = module.vnet.public_subnet_ids
  private_subnet_ids                      = module.vnet.private_subnet_ids
  azurerm_storage_account_storage_account = module.storage_account.azurerm_storage_account_storage_account
}

/* module "database" {
  source                 = "../../modules/azure/database"
  resource_group_name    = module.resource_group.name_resource_group
  environment            = var.environment
  location               = var.location
  owner                  = var.owner
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  delegated_subnet_id    = module.vnet.db_subnet
} */

module "vpn-azure" {
  source               = "../../modules/azure/vpn"
  owner                = var.owner
  location             = var.location
  environment          = var.environment
  resource_group_name  = module.resource_group.name_resource_group
  gateway_address      = module.vpn-aws.aws_vpn_connection_address
  address_space        = var.private_subnet_cidrs
  subnet_id            = module.vnet.gateway_subnet
  shared_key           = module.vpn-aws.aws_vpn_connection_key
  public_ip_address_id = module.ip_publis.id_vpn
}

/* module "azure_route_table" {
  source = "../../modules/azure/route_table"
  location            = var.location
  resource_group_name = module.resource_group.name_resource_group
  public_subnet_ids   = module.vnet.public_subnet_ids
} */