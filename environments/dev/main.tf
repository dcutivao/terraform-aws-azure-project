#-----------------------------------Infraestrucutura AWS--------------------------------------------------------
/* provider "aws" {
  region = var.aws_region
}
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
        { from_port = 3306, to_port = 3306, protocol = "tcp", cidr_blocks = ["172.16.3.0/24"] }
      ]
      egress_rules = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
    }
  ]
} */

/* module "iam" {
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
#  }
#} */

/* resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

resource "aws_key_pair" "generated" {
  key_name   = "AWS-Key-${var.environment}"
  public_key = tls_private_key.generated.public_key_openssh
}
resource "local_file" "private_key_pem" {
  content   = tls_private_key.generated.private_key_pem
  filename  = "AWS-Key-${var.environment}.pem"                                                           # en este apartado podemos indicar la ruta donde queremos que repose nuestra key("/home/armando/Descargas/MyAWSKey.pem") o solo con el nombre queda local 
} */

/* module "ec2" {
  source = "../../modules/aws/ec2"

  aws_region  = var.aws_region
  amis        = var.amis
  environment = var.environment
  instances = {
    "web-server" = {
      instance_type = "t2.micro"
      # Red a la que pertenecera public o private y la posicion según el indexado de la lista en el archivo terraform.tfvars
      subnet_id            = module.vpc.public_subnets[1]
      os                   = "amazon"
      security_groups      = [module.security_groups.security_group_ids["ec2-sg"]]
      iam_instance_profile = module.iam.iam_instance_profiles["EC2Role"]
      key_name             = aws_key_pair.generated.key_name
    }
    "db-server" = {
      instance_type        = "t2.micro"
      subnet_id            = module.vpc.private_subnets[0] # esto es la salida del ouput de la variable private_subnets del modulo ec2
      os                   = "ubuntu"
      security_groups      = [module.security_groups.security_group_ids["rds-sg"], module.security_groups.security_group_ids["ec2-sg"]]
      iam_instance_profile = module.iam.iam_instance_profiles["EC2Role"]
      key_name             = aws_key_pair.generated.key_name
    }
  }
} */

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

/* module "s3_bucket" {
  source            = "../../modules/aws/s3"
  bucket_name       = var.bucket_name
  status_versioning = "Disabled" # habilitar use Enabled
  environment       = var.environment
} */

#-----------------------------------Infraestrucutura Azure--------------------------------------------------------
provider "azurerm" {
  features {}
  resource_provider_registrations = "none" # el argumento "nome" =  Esto significa que Terraform no registrará automáticamente ningún proveedor de recursos en la suscripción de Azure.
  subscription_id                 = var.id_suscripcion
}

# Esto nos sirve para crear el grupo de recurso
resource "azurerm_resource_group" "rg" {
  name     = "${var.name_resource_group}-${var.environment}"
  location = var.location
  tags = {
    environment = "entorno-${var.environment}"
    owner       = "Armando"
  }
}

# Esto nos ayuda a construir la cuenta de almacenamiento
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Esto nos ayuda a crear el container para almacenamiento de objetos o archivos.
# usuamos el for_each para que itere sobre el array de variables y nos cree los contenedores deseados
resource "azurerm_storage_container" "container" {
  for_each              = toset(var.container)
  name                  = each.value
  storage_account_id    = azurerm_storage_account.storage_account.id
  container_access_type = "private" # Puede ser private, blob o container
}

resource "azurerm_virtual_network" "vpc" {
  name = "VirtualNetwor-${var.environment}"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = ["10.0.0.0/16"]
  subnet {
    name = "private-1-${var.environment}"
    address_prefixes = ["10.0.1.0/24"]
    }
}