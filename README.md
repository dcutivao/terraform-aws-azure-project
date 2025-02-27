## VPN Sito-to-Site between AWS and AZURE
📌 Este proyecto se realiza con la intencion de realizar una conexion entre dos nubes AWS y AZURE mediante VPN Site-to-Site, utilizando al maximo la modulación en Terraform.

************************************************************************

### VPC
Se raliza creación de la VPC de una forma mudular esto con el fin de definir region, zonas de disponibilidad, cidr y subredes hay que tener encuenta la disponibilidad de la zona de disponibilidad.

### RDS
Se realiza el moentaje de la RDS de forma modular, ya que esto permite:

- ✅ Reutilización: Puedes usar el mismo módulo para diferentes entornos (dev, staging, prod).
- ✅ Mantenibilidad: Separar la lógica de la base de datos facilita la gestión y actualización.
- ✅ Seguridad: Puedes aislar configuraciones sensibles y aplicar mejores prácticas.



Azure
📂 proyecto-infra/
├── 📂 modules/
│ ├── 📂 vnet/ (Crea la VNet y las subredes)
│ ├── 📂 nsg/ (Crea los Security Groups y asociaciones)
│ ├── 📂 public_ip/ (Crea las IPs públicas)
│ ├── 📂 network_interface/ (Crea las NICs y las asocia)