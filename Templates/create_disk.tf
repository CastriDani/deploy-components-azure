/*resource "azurerm_managed_disk" "disk" {
  name                 = "${var.vm_names}-disk2"
  location             = azurerm_resource_group.RG.location
  resource_group_name  = azurerm_resource_group.RG.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  managed_disk_id    = azurerm_managed_disk.disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.VM.id
  lun                = "10"
  caching            = "ReadWrite"
}*/