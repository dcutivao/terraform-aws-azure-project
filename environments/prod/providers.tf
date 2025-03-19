terraform {
  # Version Terraform
  required_version = "~>1.11.0" #"~>1.10.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.19.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.2"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  resource_provider_registrations = "none" # el argumento "nome" =  Esto significa que Terraform no registrará automáticamente ningún proveedor de recursos en la suscripción de Azure.
  subscription_id                 = var.id_suscripcion
}
