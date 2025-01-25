terraform {
  required_version = "~>1.10.1"
  backend "s3" {
    bucket = "my-terraform-state-daco"
    key    = "dev/terraform.tfstate" # podemos indicar donde lo podemos alojar en s3, en este caso lo estamos alojando en una carpeta llamada prod que no necesita ser creada , pero si no existe la carpeta se creara automaticamente
    region = "us-east-1"

    # Estos parametros los usuamos cuando se requiere bloqueo o cerradura a nuestro archivo de estado para que no se pueda modificar o eliminar.
    dynamodb_table = "terraform-locks-armando" # nombre de la tabla que se creo 
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.13.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.2"
    }
  }
}
