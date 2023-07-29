provider "azurerm" {
  features {}
}


resource "azurerm_windows_virtual_machine" "VM" {
  name                = "VM-Test"
  resource_group_name = "RG-Deploy-Components"
  location            = "East US"
  size                = "Standard_F2"
 
}