# Launch a virtual machine on azure that we can log into


In brief:
* [Standard_F2](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-previous-gen) virtual machine (2 vCPU, 4GB RAM, 32 GB SSD)
* westus2 (Washington state)
* Ubuntu 20.04

☝️ you can edit `terraform.tfvars` or `main.tf` to change these settings

## Deploy infrastructure (takes ~ 1min)
```
az login
terraform init
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
```

## References

* https://docs.microsoft.com/en-us/azure/developer/terraform/create-linux-virtual-machine-with-infrastructure
* https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/virtual-machines
* https://docs.microsoft.com/en-us/azure/virtual-machines/sizes
