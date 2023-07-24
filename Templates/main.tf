# Especifica el proveedor de Azure que se utilizará
provider "azurerm" {
  features {}
}

# Crea un grupo de recursos en Azure
resource "azurerm_resource_group" "example" {
  name     = "RG-Deploy-Components"  # Especifica el nombre del grupo de recursos
  location = "East US"        # Especifica la región donde se creará el grupo de recursos
}

# Crea una red virtual en Azure
resource "azurerm_virtual_network" "example" {
  name                = "VNET-Test"  # Especifica el nombre de la red virtual
  address_space       = ["10.0.0.0/16"]       # Especifica el rango de direcciones IP para la red virtual
  location            = azurerm_resource_group.example.location  # Obtiene la región del grupo de recursos
  resource_group_name = azurerm_resource_group.example.name       # Obtiene el nombre del grupo de recursos
}

# Crea una subred en la red virtual
resource "azurerm_subnet" "example" {
  name                 = "Subnet-Test"                      # Especifica el nombre de la subred
  resource_group_name  = azurerm_resource_group.example.name       # Obtiene el nombre del grupo de recursos
  virtual_network_name = azurerm_virtual_network.example.name      # Obtiene el nombre de la red virtual
  address_prefixes     = ["10.0.1.0/24"]                  # Especifica el rango de direcciones IP para la subred
}

# Crea una IP pública en Azure
resource "azurerm_public_ip" "example" {
  name                         = "Publi-IP"               # Especifica el nombre de la IP pública
  location                     = azurerm_resource_group.example.location  # Obtiene la región del grupo de recursos
  resource_group_name          = azurerm_resource_group.example.name       # Obtiene el nombre del grupo de recursos
  allocation_method            = "Dynamic"                    # Especifica el método de asignación de IP (dinámico)
  idle_timeout_in_minutes      = 30                           # Especifica el tiempo de inactividad antes de liberar la IP
}

# Crea una interfaz de red en Azure
resource "azurerm_network_interface" "example" {
  name                      = "NI-Test"         # Especifica el nombre de la interfaz de red
  location                  = azurerm_resource_group.example.location  # Obtiene la región del grupo de recursos
  resource_group_name       = azurerm_resource_group.example.name       # Obtiene el nombre del grupo de recursos

  ip_configuration {
    name                          = "IP-configuration"     # Especifica el nombre de la configuración de IP
    subnet_id                     = azurerm_subnet.example.id  # Obtiene el ID de la subred creada anteriormente
    private_ip_address_allocation = "Dynamic"                # Especifica el método de asignación de IP privada (dinámico)
    public_ip_address_id          = azurerm_public_ip.example.id  # Obtiene el ID de la IP pública creada anteriormente
  }

  # Vincula el NSG creado anteriormente
  network_security_group_id = azurerm_network_security_group.example.id
}

# Crea un Grupo de Seguridad de Red (NSG) en Azure
resource "azurerm_network_security_group" "example" {
  name                = "NSG-Test"                                 # Especifica el nombre del NSG
  location            = azurerm_resource_group.example.location  # Obtiene la región del grupo de recursos
  resource_group_name = azurerm_resource_group.example.name       # Obtiene el nombre del grupo de recursos
}

# Crea una regla para permitir tráfico SSH en el NSG
resource "azurerm_network_security_rule" "ssh_rule" {
  name                        = "SSHRule"                        # Especifica el nombre de la regla del NSG para SSH
  priority                    = 100                              # Especifica la prioridad de la regla (mayor número tiene mayor prioridad)
  direction                   = "Inbound"                        # Especifica la dirección del tráfico (entrada)
  access                      = "Allow"                          # Especifica la acción permitida (permitir el tráfico)
  protocol                    = "Tcp"                            # Especifica el protocolo (TCP)
  source_port_range           = "*"                              # Especifica el rango de puertos de origen (cualquier puerto)
  destination_port_range      = "22"                             # Especifica el puerto de destino para SSH (puerto 22)
  source_address_prefix       = "*"                              # Especifica la dirección IP de origen (cualquier dirección)
  destination_address_prefix  = "*"                              # Especifica la dirección IP de destino (cualquier dirección)
  resource_group_name         = azurerm_resource_group.example.name       # Obtiene el nombre del grupo de recursos
  network_security_group_name = azurerm_network_security_group.example.name  # Obtiene el nombre del NSG
}

# Crea una regla para permitir tráfico RDP en el NSG
resource "azurerm_network_security_rule" "rdp_rule" {
  name                        = "RDPRule"                        # Especifica el nombre de la regla del NSG para RDP
  priority                    = 101                              # Especifica la prioridad de la regla (un número mayor tiene mayor prioridad)
  direction                   = "Inbound"                        # Especifica la dirección del tráfico (entrada)
  access                      = "Allow"                          # Especifica la acción permitida (permitir el tráfico)
  protocol                    = "Tcp"                            # Especifica el protocolo (TCP)
  source_port_range           = "*"                              # Especifica el rango de puertos de origen (cualquier puerto)
  destination_port_range      = "8080"                           # Especifica el puerto de destino para RDP (puerto 3389)
  source_address_prefix       = "*"                              # Especifica la dirección IP de origen (cualquier dirección)
  destination_address_prefix  = "*"                              # Especifica la dirección IP de destino (cualquier dirección)
  resource_group_name         = azurerm_resource_group.example.name       # Obtiene el nombre del grupo de recursos
  network_security_group_name = azurerm_network_security_group.example.name  # Obtiene el nombre del NSG
}

#Crea una maquina virtual
resource "azurerm_virtual_machine" "example" {
  name                  = "VM-Test"             # Especifica el nombre de la máquina virtual
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "disk1"                    # Especifica el nombre del disco del sistema operativo
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"               # Especifica el editor de la imagen (Microsoft para Windows)
    offer     = "WindowsServer"                       # Especifica la oferta de la imagen (WindowsServer para Windows)
    sku       = "2019-Datacenter"                     # Especifica el SKU de la imagen (por ejemplo, "2019-Datacenter" para Windows Server 2019)
    version   = "latest"                               # Especifica la versión de la imagen (la última versión disponible)
  }

  os_profile {
    computer_name  = "VM-Test1"                            # Especifica el nombre del equipo de la máquina virtual
    admin_username = "admin"                       # Especifica el nombre de usuario del administrador
    admin_password = "Admin1213!"                   # Especifica la contraseña del administrador
  }

  os_profile_linux_config {
    disable_password_authentication = false           # Habilita la autenticación mediante contraseña para sistemas Linux
  }

  tags = {
    environment = "dev"                                # Etiqueta adicional para identificar el entorno (dev, prod, etc.)
  }
}


