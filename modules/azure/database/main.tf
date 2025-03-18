resource "azurerm_mysql_flexible_server" "db-mysql" {
  name                   = "mysql-environment-${var.environment}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  sku_name               = "B_Standard_B1s" # Plan más barato
  version                      = "8.0.21"
  backup_retention_days        = 7 # Reduce costos de backup
  geo_redundant_backup_enabled = false
  zone                         = "1"
  delegated_subnet_id          = var.delegated_subnet_id # Delegación de subred

  storage {
    size_gb           = 20
    auto_grow_enabled = false # Desactiva el crecimiento automático para ahorrar costos
  }

  tags = {
    environment = var.environment
    owner       = var.owner
    terraform   = "true"
  }
}

resource "azurerm_mysql_flexible_database" "db" {
  name                = "${var.environment}-mydatabase"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.db-mysql.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
}
