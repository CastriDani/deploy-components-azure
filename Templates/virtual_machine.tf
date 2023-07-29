locals {
  vm_name = "${var.vm_names}-Test"
}


resource "azurerm_windows_virtual_machine" "VM" {
  name                = local.vm_name
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = var.vm_size
  admin_username      = "admin123"
  admin_password      = "Admin123!"
  network_interface_ids = [
    azurerm_network_interface.NIC.id,
  ]

    os_disk {
    name               = ${var.vm_names}-os_disk
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }


  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}