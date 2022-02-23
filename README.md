# Infrastructure-as-code on Azure

This repository contains [Terraform](https://www.terraform.io) code, to easily
create and remove Cloud resources on Microsoft Azure.

## Setup

We'll use `conda` to create an environment that includes command line utilities
to execute code in this repository. In particular, we need `terraform` and the
[Azure Command Line Interface (CLI)](https://docs.microsoft.com/en-us/cli/azure/)""

```
conda env create
conda activate azure
```

Authenticate to Azure via a Microsoft account (uw email) connected to our
Azure "Subscription"
```
az login
```

Check current login credentials:
```
az account show
```

## Initial Setup

Terraform keeps track of Cloud resources in "state" files, which are stored in
in a "storage account container" backend (equivalent to AWS "S3 bucket"). It is first
necessary to create this storage account container, as all other pieces of infrastructure
are tracked there:

```
cd backend
terraform apply
```
NOTE: `.tfstate` files are created separately for each collection of infrastructure,
under the [STORAGE_ACCOUNT]/[CONTAINER]/[KEY], for example for our basic_virtual_machine
the configuration is tracked in `az://tfstate5063/tfstate/linux-vm.tfstate`


## Organization

Each subfolder contains a stand-alone logical group of Cloud resources. To create the infrastructure,
navigate to a subfolder in the terminal and follow the README.md instructions. But in brief
you should only need to edit `terraform.tfvars` and then run `terraform apply`, and when you're done
with the resources `terraform destroy`

| subfolder | description |
| - | - |
| basic_virtual_machine | Launch a virtual machine with Ubuntu 20.04 |
| azure_file_share_data | Network attachable drive (mountable via smb://) |
| azure_file_share_home | A persistant 50GB home directory for Jupyter Servers (/home/jovyan) |
| aci_plus_volume | JupyterLab via Azure Container Instance with a Docker container and azure_file_share_home volume |
| batch | Run a Docker container via Azure Batch (non public) |
| batch_vpn | Run a Docker container with public IP |
| blob_storage | Create a blob storage bucket (Azure storage account container) |


## References

https://docs.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash
