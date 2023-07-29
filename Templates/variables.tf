# name VM

variable "vm_names" {
  default   = "VM"
}

# Change the size to the virtual machine

variable "vm_size" {
    default    = "Standard_F1"
}

# extend VNET segment




# Add new subnet
/*
variable "subnet_names" {
  description = "Lista de nombres para las subredes"
  type        = list(string)
  default     = ["SubnetA", "SubnetB"]  # Agrega más nombres de subredes si es necesario
}

variable "subnet_cidrs" {
  description = "Lista de CIDRs para las subredes"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]  # Agrega más CIDRs de subredes si es necesario
}
*/

