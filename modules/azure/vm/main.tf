#---------------------Creacion de maquina virtual VM Publica------------------------------------
resource "azurerm_linux_virtual_machine" "vm_linux_public" {
  count                 = var.vm_public_count
  name                  = "vm-public-${count.index}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_DS1_v2"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic-vm-public[count.index].id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub") # Ruta a tu clave pública ejemplo: "~/.ssh/id_rsa.pub"
  }

  os_disk {
    name                 = "myosdisk-public-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.vm_version
  }

  boot_diagnostics {
    storage_account_uri = var.azurerm_storage_account_storage_account
  }

  custom_data = filebase64("cloud-init.txt")
  tags = {
    "environment" = "entorno-${var.environment}"
    "owner"       = var.owner
  }
}


# Creacion de tarjeta de red que utilizara la VM
resource "azurerm_network_interface" "nic-vm-public" {
  count               = var.vm_public_count
  name                = "nic-vm-public-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ip-vm-${count.index}"
    subnet_id                     = var.public_subnet_ids[count.index + 1]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.list_ip_public[count.index]   # descometaria en caso de que se requiera
  }
  tags = {
    "environment" = "entorno-${var.environment}"
  }
}

#---------------------Creacion de maquina virtual VM Private------------------------------------

resource "azurerm_linux_virtual_machine" "vm_linux_private" {
  count                 = var.vm_private_count
  name                  = "vm-private-${count.index}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_DS1_v2"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic-vm-private[count.index].id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub") # Ruta a tu clave pública ejemplo: "~/.ssh/id_rsa.pub"
  }

  os_disk {
    name                 = "myosdisk-private-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.vm_version
  }

  boot_diagnostics {
    storage_account_uri = var.azurerm_storage_account_storage_account
  }
  tags = {
    "environment" = "entorno-${var.environment}"
    "owner"       = var.owner
  }
}


# Creacion de tarjeta de red que utilizara la VM
resource "azurerm_network_interface" "nic-vm-private" {
  count               = var.vm_private_count
  name                = "nic-vm-private${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ip-vm-${count.index}"
    subnet_id                     = var.private_subnet_ids[count.index]
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    "environment" = "entorno-${var.environment}"
  }
}