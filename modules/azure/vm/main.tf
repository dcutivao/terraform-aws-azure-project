# Creacion de maquina virtual VM
resource "azurerm_linux_virtual_machine" "vm_linux" {
  count                 = var.vmcount
  name                  = "vm-${count.index}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_DS1_v2"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic-vm[count.index].id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub") # Ruta a tu clave pública ejemplo: "~/.ssh/id_rsa.pub"
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
resource "azurerm_network_interface" "nic-vm" {
  count               = var.vmcount
  name                = "nic-vm-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ip-vm-${count.index}"
    subnet_id                     = var.public_subnet_ids[count.index] #azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.list_ip_public[count.index] #azurerm_public_ip.ip[count.index].id
  }
  tags = {
    "environment" = "entorno-${var.environment}"
  }
}