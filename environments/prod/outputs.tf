#---------------Outputs AWS-------------------------------------------
output "bucket_arn" {
  value = module.s3_bucket.bucket_arn[*]
}

output "rds_endpoint" {
  description = "Enpoint conexion DB"
  value = "Para conectarse: mysql -h ${module.rds.rds_endpoint} -u ${module.rds.rds_username} -p<contraseña> -D ${module.rds.rds_database_name}"
}

output "aws_vpn_connection_address" {
  value = "Ip publica VPN AWS: ${module.vpn-aws.aws_vpn_connection_address}"
}

#-----------------------------------------------------------------------------------------------
# conexion DB =  mysql -h <host> -u <usuario> -p<contraseña> -D <nombre_de_la_base_de_datos>
#-----------------------------------------------------------------------------------------------

#---------------Outputs Azure-------------------------------------------------------------------

output "azurerm_storage_account_id" {
  value = module.storage_account.azurerm_storage_account_id
}

output "mysql_connection_string" {
  value = "Para conectarse: mysql -h ${module.database.mysql_connection_string} -u ${var.administrator_login} -p<contraseña> -D ${module.database.mysql_server_name}"
}

output "ip_vpn" {
  value = "Ip publica VPN Azure: ${module.ip_publis.ip_vpn}"
}