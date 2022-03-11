# Infrastructure-as-code on Azure

This repository contains [Terraform](https://www.terraform.io) code, to easily
create and remove Cloud resources on Microsoft Azure:

| subfolder | description |
| - | - |
| basic_virtual_machine | Virtual machine with Ubuntu 20.04 |
| azure_file_share_data | Network attachable drive (mountable via smb://) |
| aci_plus_volume | JupyterLab Docker Container via Azure Container Instance with azure_file_share_data home directory |
| virtual_machine_gpu | GPU Virtual Machine with NVIDIA Drivers + conda preinstalled |

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

## Organization

Each subfolder contains a stand-alone logical group of Cloud resources. To create the infrastructure,
navigate to a subfolder in the terminal and follow the README.md instructions.

### Workspaces
Each subfolder contains a recipe for a group of cloud resources with a self-describing subfolder name (basic_virtual_machine). Let's say several lab members each need a virtual machine. The recipe is the same and each time we use it, we create a new [Terraform Workspace](https://www.terraform.io/language/state/workspaces) to keep track of the Cloud resources created and not interfere with one another. For example:

```
cd basic_virtual_machine

# Connect to state backend (see 'Initial Setup' section below)
terraform init

terraform workspace new scott-incubator2022

# Optionally edit terraform.tfvars to change things like region or machine type
terraform apply

# Easily remove any costly Cloud resources
terraform destroy
terraform workspace delete scott-incubator2022
```

## Initial Setup

NOTE: this only needs doing once. We did it in Feb 2022 and are just leaving notes here for future reference

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


## References

https://docs.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash
