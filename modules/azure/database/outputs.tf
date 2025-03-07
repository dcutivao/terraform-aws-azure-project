# salida chatgpt

output "mysql_connection_string" {
  value = "mysql://${azurerm_mysql_flexible_server.db-mysql.administrator_login}@${azurerm_mysql_flexible_server.db-mysql.fqdn}:3306/${azurerm_mysql_flexible_database.db.name}"
}

# salida deepseep

output "mysql_server_name" {
  value = azurerm_mysql_flexible_database.db.name
}

output "mysql_server_fqdn" {
  value = azurerm_mysql_flexible_server.db-mysql.fqdn
}