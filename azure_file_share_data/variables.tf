variable "location" {
  default     = "westus2"
  description = "The Azure Region in which all resources in this example should be created."
}

variable "disk_size" {
  default     = "50"
  description = "The maximum size of the share, in gigabytes"
}
