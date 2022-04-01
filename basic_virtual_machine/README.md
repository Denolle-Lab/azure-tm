# Launch a virtual machine on azure that we can log into

In brief:
* [Standard_F2](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-previous-gen) virtual machine (2 vCPU, 4GB RAM, 32 GB SSD)
* westus2 (Washington state)
* Ubuntu 20.04

## Deploy infrastructure (takes ~ 2min)
💡 NOTE: Name your workspace something informative! All Cloud resources will appear under an Azure Resource Group with the workspace name ("scott-incubator2022" in the example below"):

👀 NOTE: You can add a separate variable file instead of using the default `terraform.tfvars`. This is helpful for storing multiple configurations for other lab members to see and not interfere with version control. Just remember to point to it when you use `terraform apply -var-file="scott-incubator2022.tfvars"`

```
terraform init
terraform workspace new scott-incubator2022
terraform apply
```

## Get login info
```
terraform state pull
```

## Remote access (get public IP address)
```
az vm list-ip-addresses -n test-vm -o table
ssh -Y adminuser@20.69.102.24
```

## Clean up when you're done!
```
terraform destroy
terraform workspace delete scott-incubator2022
```

## References

* https://docs.microsoft.com/en-us/azure/developer/terraform/create-linux-virtual-machine-with-infrastructure
* https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/virtual-machines
* https://docs.microsoft.com/en-us/azure/virtual-machines/sizes
