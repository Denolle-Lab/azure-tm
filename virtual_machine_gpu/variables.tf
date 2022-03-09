variable "location" {
  default     = "westus2"
  description = "The Azure Region in which all resources in this example should be created."
}

variable "vmsize" {
  default     = "Standard_NC6s_v3"
  description = "Azure Virtual Machine Size"
}

variable "os_disk_size" {
  default     = "32"
  description = "Azure Virtual Machine Disk Size (GiB)"
}

# az vm image list --offer linux-data-science-vm --all --output table
# variable "vmimage" {
#   default = "linux-data-science-vm"
#   description = "Azure Virtual Machine Size"
# }
