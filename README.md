## Proyecto: Conectividad Multi-Nube con Terraform – VPN Site-to-Site entre AWS y Azure

### Descripción
📌 Este proyecto implementa una infraestructura multi-nube utilizando Terraform para conectar AWS y Azure mediante una VPN Site-to-Site. Además de la conectividad segura entre ambas nubes, el despliegue incluye:

* Instancias en AWS y Azure (EC2 y Virtual Machine).
* Bases de datos en ambas nubes (RDS en AWS y MySQL Flexible Server en Azure).
* Seguridad mediante Security Groups en AWS y reglas de Network Security Groups (NSG) en Azure.
* Almacenamiento con Amazon S3 y Azure Blob Storage (Containers).
* Gestión de claves SSH:
    - Se genera una clave SSH en AWS para acceder a la instancia EC2.
    - Se crea una clave local para conectarse a la máquina virtual en Azure.
* Estructura de entornos:
    - Cada entorno (Dev, Staging, Prod) se despliega en una región distinta utilizando directorios separados en Terraform.
    - No se utilizan Workspaces, sino una estructura de carpetas para la organización de los entornos.


************************************************************************
## Se realiza el moentaje de forma modular, ya que esto permite:

- ✅ Reutilización: Puedes usar el mismo módulo para diferentes entornos (dev, staging, prod).
- ✅ Mantenibilidad: Separar la lógica de la base de datos facilita la gestión y actualización.
- ✅ Seguridad: Puedes aislar configuraciones sensibles y aplicar mejores prácticas.


************************************************************************
## Estructura del Proyecto

- 📂 terraform-aws-azure-project/
- │── 📂 environments/
- │   ├── 📂 dev/
- │   │   ├── backend.tf
- │   │   ├── cloud-init.txt
- │   │   ├── main.tf
- │   │   ├── outputs.tf
- │   │   ├── provider.tf
- │   │   ├── terraform.tfvars
- │   │   ├── variables.tf
- │   ├── 📂  prod/
- │   │   ├── backend.tf
- │   │   ├── cloud-init.txt
- │   │   ├── main.tf
- │   │   ├── outputs.tf
- │   │   ├── provider.tf
- │   │   ├── terraform.tfvars
- │   │   ├── variables.tf
- │   ├── 📂 staging/
- │   │   ├── backend.tf
- │   │   ├── cloud-init.txt
- │   │   ├── main.tf
- │   │   ├── outputs.tf
- │   │   ├── provider.tf
- │   │   ├── terraform.tfvars
- │   │   ├── variables.tf
- │── 📂 modules/
- │   ├── 📂 aws/
- │   │   ├── 📂 ec2/
- │   │   ├── 📂 iam/
- │   │   ├── 📂 rds/
- │   │   ├── 📂 route_table/
- │   │   ├── 📂 s3/
- │   │   ├── 📂 security_groups/
- │   │   ├── 📂 vpc/
- │   │   ├── 📂 vpn/
- │   ├── 📂 azure/
- │   │   ├── 📂 database/
- │   │   ├── 📂 ip-publics/
- │   │   ├── 📂 nsg/
- │   │   ├── 📂 resource_group/
- │   │   ├── 📂 route_table/
- │   │   ├── 📂 storage_account/
- │   │   ├── 📂 storage_container/
- │   │   ├── 📂 vm/
- │   │   ├── 📂 vnet/
- │   │   ├── 📂 vpn/
- │   ├── 📂 key/
- │── README.md
- │── .gitignore
- │── Infraestructura_aws_&_azure.svg

************************************************************************
## Diagrama de Infraestrucutura

![Diagrama de Infraestrucutura](./Infraestructura_aws_&_azure.svg)

<p align="center">
  <img src="./Infraestructura_aws_&_azure.svg" alt="Arquitectura VPN Multi-Nube" width="600"/>
</p>

