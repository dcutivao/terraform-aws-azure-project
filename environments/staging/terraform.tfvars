#--------------------------------------Variables-Infraestructura-AWS---------------------------------------------------------
# Eligue la region a deszplegar el servicio:
aws_region = "us-west-2"

# Elige la cantidad de zonas de disponibilidad donde quieres de terner tus subredes:
availability_az = ["us-west-2a", "us-west-2b"]

# Eligue la cantidad de subredes publicas a desplegar teniendo encuenta la disponibilidad de az en la region:
public_subnet_count = 2
# Elige la cantidad de subredes privadas a desplegar teniendo encuenta la disponibilidad de az en la region:
private_subnet_count = 2

# Elige la red global de tu red:
vpc_cidr = "172.16.0.0/16"

# Elige la la cantidad de subredes publicas con su prefijo temiendo encuenta el cird:
public_subnet_cidrs = ["172.16.1.0/24", "172.16.2.0/24"]
# Elige la cantidad de subredes privadas con su prefijo temiendo encuenta el
private_subnet_cidrs = ["172.16.3.0/24", "172.16.4.0/24"]

# Nombre de Bucket
bucket_name = "bucket-daco-environment"

#---------------------------------------Variables compartidas---------------------------------------------

# Eleige el entorno el cual quieres desplegar:
environment = "dev"
# Colocar el nombre del propietario de los recursos desplegados:
owner = "Armando"

#--------------------------------------Variables-Infraestructura-Azure---------------------------------------------------------

# Region=location, en la cual quiere desplegar los recursos de Azure:
location            = "West US 2"
id_suscripcion      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
name_resource_group = "Grupo-de-recursos-Azure"

# Colocar el nievel de Cuenta Azure
account_tier = "Standard"
# Colocar el nivel de almacenamiento de la cuenta Azure
account_replication_type = "LRS"

# Colocar nombres en una lista para los container de almacenamiento de archivos u objetos
storage_container_name = ["storagelogs", "movements", "diego"]
# Tipo de acceso para los container creados private o public
container_access_type = "private"


# Elige la red global de tu red:
address_space = ["10.0.0.0/16"]
# Elige la la cantidad de subredes publicas con su prefijo temiendo encuenta el cird:
public_subnets = [
  { name = "public-subnet-1", address_prefix = "10.0.1.0/24" },
  { name = "public-subnet-2", address_prefix = "10.0.2.0/24" }
]
# Elige la cantidad de subredes privadas con su prefijo temiendo encuenta el
private_subnets = [
  { name = "private-subnet-1", address_prefix = "10.0.7.0/24" }
]


# numero de maquinas virtuales OS Linux(Ubuntu) a desplegar VM
vm_public_count  = 1
vm_private_count = 1
# Especifica el editor de la imagen
publisher = "Canonical"
# Especificar la oferta de la imagen
offer = "UbuntuServer"
# Especifica la versión o edición del sistema operativo
sku = "16.04-LTS"
# Puedes usar latest para obtener la última versión disponible
vm_version = "latest"

# Despleigue DB-mysql Azure
administrator_login    = "adminuser"
administrator_password = "Pueden_copiar_el_P@ssw0rd1234!"