variable "prefix" {
  default     = "container-test"
  description = "The prefix which should be used for all resources in this example"
}

variable "location" {
  default     = "westus2"
  description = "The Azure Region in which all resources in this example should be created."
}

variable "cpu" {
  default     = "1"
  description = "Number of CPUs"
}

variable "ram" {
  default     = "8"
  description = "Amount of RAM (GB)"
}

variable "image" {
  default     = "uwessds/seisbench:latest"
  description = "Image on DockerHub to pull and run"
}

variable "file_share" {
  default     = "seisbench"
  description = "Azure File Share Name"
}

variable "file_share_storage_account" {
  default     = "seisbench"
  description = "Storage Account which Azure File Share is is"
}
