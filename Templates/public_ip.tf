resource "azurerm_public_ip" "IPPUBLIC" {
  name                = "Public-IP"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  allocation_method   = "Dynamic"
}