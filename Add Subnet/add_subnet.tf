provider "azurerm" {
  features {}
}

resource "azurerm_subnet" "SubnetB" {
  name                  = "SubnetB"
  resource_group_name   = "RG-Deploy-Components"
  virtual_network_name  = "VNET-Test"
  address_prefixes      = ["10.0.2.0/24"]
}