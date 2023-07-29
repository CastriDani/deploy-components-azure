resource "azurerm_subnet" "SubnetA" {
  name                 = "SubnetA"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.VNET.name
  address_prefixes     = ["10.0.1.0/24"]
}

/*
resource "azurerm_subnet" "SubnetB" {
  name                  = "SubnetB"
  resource_group_name   = azurerm_resource_group.RG.name
  virtual_network_name  = azurerm_virtual_network.VNET.name
  address_prefixes      = ["10.0.2.0/24"]
}
*/
