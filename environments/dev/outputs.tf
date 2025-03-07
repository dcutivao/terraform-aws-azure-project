#---------------Outputs AWS-------------------------------------------

/* output "vpc_id" {
  value = module.vpc.vpc_id
}
output "bucket_arn" {
  value = module.s3_bucket.bucket_arn[*]
}

output "rds_endpoint" {
  description = "Enpoint conexion DB"
  value = module.rds.rds_endpoint
} */

#---------------Outputs Azure-------------------------------------------

/* output "public_ip_address" {
  value = azurerm_public_ip.ip[*].ip_address
} */

/* output "azurerm_storage_account_id" {
  value = module.storage_account.azurerm_storage_account_id
} */

output "salida_privada" {
  value = module.vnet.private_subnet_ids
}

output "salida_publica" {
  value = module.vnet.public_subnet_ids
}

output "mysql_connection_string" {
  value = module.database.mysql_connection_string
}


#--------------------------------------------------------
/* output "public_subnet_ids" {
  value = "todas_Publicas-${module.vnet.public_subnet_ids}" #azurerm_subnet.public[*].id
}

output "private_subnet_ids" {
  value = "todas-Privadas-${module.vnet.private_subnet_ids}" #azurerm_subnet.private[*].id
} */

output "public_subnet_ids_0" {
  value = "todas_Publicas-0-${module.vnet.public_subnet_ids_0}" #azurerm_subnet.public[*].id
}

output "public_subnet_ids_1" {
  value = "todas-Publicas-1-${module.vnet.public_subnet_ids_1}" #azurerm_subnet.private[*].id
}

output "private_subnet_ids_0" {
  value = "todas_Privadas--0-${module.vnet.private_subnet_ids_0}" #azurerm_subnet.public[*].id
}

output "private_subnet_ids_1" {
  value = "todas-Privadas--1-${module.vnet.private_subnet_ids_1}" #azurerm_subnet.private[*].id
}