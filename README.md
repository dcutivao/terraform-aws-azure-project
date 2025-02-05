## VPN Sito-to-Site between AWS and AZURE
📌 Este proyecto se realiza con la intencion de realizar la conexion entre dos nubes AWS y AZURE mediante VPN Site-to-Site, utilizando al maximo la modulación de Terraform.

************************************************************************
### RDS
Sí, es recomendable montar la RDS de forma modular, ya que esto permite:
✅ Reutilización: Puedes usar el mismo módulo para diferentes entornos (dev, staging, prod).
✅ Mantenibilidad: Separar la lógica de la base de datos facilita la gestión y actualización.
✅ Seguridad: Puedes aislar configuraciones sensibles y aplicar mejores prácticas.