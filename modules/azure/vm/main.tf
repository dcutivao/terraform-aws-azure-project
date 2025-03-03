# Creacion de maquina virtual VM
resource "azurerm_linux_virtual_machine" "example" {
  count                 = var.vmcount
  name                  = "vm-${count.index}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_DS1_v2"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic-vm[count.index].id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub") # Ruta a tu clave pública
  }

  os_disk {
    name                 = "myosdisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.version
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.storage_account.primary_blob_endpoint
  }
  tags = {
    "environment" = "entorno-${var.environment}"
    "owner"       = var.owner
  }

  /* os_profile_linux_config {
    disable_password_authentication = true
  } */
}


# Creacion de tarjeta de red que utilizara la VM
resource "azurerm_network_interface" "nic-vm" {
  count               = var.vmcount
  name                = "nic-vm-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ip-vm-${count.index}"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip[count.index].id
  }
  tags = {
    "environment" = "entorno-${var.environment}"
  }
}