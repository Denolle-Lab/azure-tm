# Launch a virtual machine on azure with a single GPU

Launch machine with an NVIDIA GPU

## Launch

```
terraform init
terraform workspace new scott-NCv3
terraform apply --var-file="scott-NCv3.tfvars"
```

```
terraform destroy
```


## Abbreviated summary of machine types

NOTE: [As of 3/2022 Azure recommends NCv3 or newer](https://docs.microsoft.com/en-us/azure/virtual-machines/n-series-migration)

## NC-series

* NC-series VMs are powered by the NVIDIA Tesla K80 card and the Intel Xeon E5-2690 v3 (Haswell) processor.

| Size |	vCPU |	Memory: GiB |	Temp storage (SSD) GiB |	GPU |	GPU memory: GiB |	Max data disks |	Max NICs |
| - |	- |	- |	-|	- |	- |	- |	- |
|Standard_NC6 |	6 |	56 |	340 |	1 |	12 | 24 | 1 |
|Standard_NC12|	12 |	112 |	680 |	2	 |24	| 48	| 2 |

*NOTE: 1 GPU = one-half K80 card.*

## NCv2-series

* NCv2-series VMs are powered by NVIDIA Tesla P100 GPUs. These GPUs can provide more than 2x the computational performance of the NC-series.

| Size |	vCPU |	Memory: GiB |	Temp storage (SSD) GiB |	GPU |	GPU memory: GiB |	Max data disks | Max uncached disk throughput: IOPS/MBps |	Max NICs |
| - |	- |	- |	-|	- |	- |	- |	- | - |
| Standard_NC6s_v2 |	6 |	112 |	736 |	1 |	16 |	12 |	20000/200 |	4 |

*NOTE: 1 GPU = one P100 card.*

## NCv3-series

* NCv3-series VMs are powered by NVIDIA Tesla V100 GPUs. These GPUs can provide 1.5x the computational performance of the NCv2-series.

| Size |	vCPU |	Memory: GiB |	Temp storage (SSD) GiB |	GPU |	GPU memory: GiB |	Max data disks | Max uncached disk throughput: IOPS/MBps |	Max NICs |
| - |	- |	- |	-|	- |	- |	- |	- | - |
| Standard_NC6s_v3 |	6 |	112 |	736 |	1 |	16 |	12 |	20000/200 |	4 |
| Standard_NC12s_v3 |	12 |	224 |	1474 |	2 |	32 |	24 |	40000/400 |	8 |
| Standard_NC24s_v3	| 24	| 448 |	2948 |	4 |	64	| 32	| 80000/800 |	8 |


*NOTE: 1 GPU = one V100 card.*

*NOTE: Temp storage (SSD) GiB is automatically mounted at `/mnt`, but you need to change permissions for non-root users: `sudo chmod -R a+w /mnt`*


## References

* https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
* https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-gpu

* https://azuremarketplace.microsoft.com/en-US/
* https://azuremarketplace.microsoft.com/en-us/marketplace/apps/nvidia.pytorch_from_nvidia?tab=PlansAndPrice
* https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension


## Troubleshooting

### What ready-to-use machine images are available?
NOTE: NVIDIA provides free curated machine images, but you have to accept terms
to use them

`az vm image list --offer nvidia --all --output table`

`az vm image show --location westus --urn nvidia:pytorch_from_nvidia:ngc-pytorch-version-21-11-0:21.11.0`

`az vm image terms accept --urn nvidia:pytorch_from_nvidia:ngc-pytorch-version-21-11-0:21.11.0`

* https://docs.nvidia.com/ngc/ngc-deploy-public-cloud/ngc-azure/index.html
* https://docs.microsoft.com/en-us/azure/virtual-machines/linux/cli-ps-findimage

### Mount an Azure File Share drive
https://github.com/Denolle-Lab/azure/tree/main/azure_file_share_data#linux-terminal

### How many of a particular VM can I run at a time?
https://portal.azure.com/#blade/Microsoft_Azure_Capacity/UsageAndQuota.ReactView/Parameters/%7B%22subscriptionId%22%3A%229630d625-8e9f-445e-acd8-85b3083e766e%22%2C%22selectedRps%22%3A%5B%22Microsoft.Compute%22%5D%2C%22defaultTitleSubscriptionName%22%3A%22Microsoft%20Azure%20Sponsorship%202%22%7D

### Run a script at startup
http://hypernephelist.com/2019/06/25/azure-vm-custom-script-extensions-with-terraform.html
