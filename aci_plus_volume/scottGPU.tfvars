prefix   = "scott"
location = "westus2"
image    = "uwessds/seisbench:2022.03.03"
# NOTE: that you must set compatible resource limit requests!
# https://docs.microsoft.com/en-us/azure/container-instances/container-instances-region-availability
cpu      = "4"
ram      = "16"
gpu      = true
gpu_type = "K80"
# Azure File share information
file_share_resource_group  = "scott-fileshare-data"
file_share_name            = "grizzly"
file_share_storage_account = "grizzly6zua"
