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

variable "gpu" {
  default     = false
  description = "Whether to attach a GPU"
}

variable "gpu_type" {
  default     = "K80"
  description = "One of: K80, P100, or V100 (increasing performance)"
}

variable "file_share_resource_group" {
  default     = "seisbench"
  description = "Azure File Resouce Group"
}

variable "file_share_name" {
  default     = "seisbench"
  description = "Azure File Share Name"
}

variable "file_share_storage_account" {
  default     = "seisbench"
  description = "Storage Account which Azure File Share is is"
}
