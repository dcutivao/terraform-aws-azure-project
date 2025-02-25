terraform {
  backend "s3" {
    bucket = "my-terraform-state-daco"
    key    = "dev/terraform.tfstate" # podemos indicar donde lo podemos alojar en s3, en este caso lo estamos alojando en una carpeta llamada prod que no necesita ser creada , pero si no existe la carpeta se creara automaticamente
    region = "us-east-1"

    # Estos parametros los usuamos cuando se requiere bloqueo o cerradura a nuestro archivo de estado para que no se pueda modificar o eliminar.
    dynamodb_table = "terraform-locks-armando" # nombre de la tabla que se creo 
    encrypt        = true
  }
}