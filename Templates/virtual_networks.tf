resource "azurerm_virtual_network" "VNET" {
  name                = "VNET-Test"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
}