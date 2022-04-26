# Azure Virtual Machine + GPU

Launch machine with a *single* NVIDIA GPU

## Launch

```
terraform init
terraform workspace new scott-NCv3
terraform apply --var-file="scott-NCv3.tfvars"
```

⚠️ GPUs are expensive, so delete these resources when not in use! 
```
terraform destroy --var-file="scott-NCv3.tfvars"
terraform workspace delete scott-NCv3
```


## Abbreviated summary of machine types

> ⚠️ NOTE: [As of 3/2022 Azure recommends v3 or newer](https://docs.microsoft.com/en-us/azure/virtual-machines/n-series-migration). "[NC_v3-series](https://docs.microsoft.com/en-us/azure/virtual-machines/ncv3-series) VMs are powered by the NVIDIA Tesla GPUs and the Intel CPUs. NC_v2 can provide 2x the computational performance of the NC-series, and NC_v3 can provide 1.5x the computational performance of the NCv2-series." 

| Size |	vCPU |	Memory (GiB) |	Temp SSD (GiB) |	GPU |	GPU memory (GiB) | Max uncached disk throughput (IOPS/MBps) |Expected network bandwidth (Mbps) | Cost ($/hr) |
| - |	- |	- |	- |	- |	- |	- | - | - |
| Standard_NC12 |	12 |	112 |	680 |	K80	 | 24	| ? | ? | $1.80  |
| Standard_NC6s_v2 |	6 |	112 |	736 |	P100 |	16 |	20000/200 |	? | $2.07 |
| **Standard_NC6s_v3** |	6 |	112 |	736 |	V100 |	16 |	20000/200 | ? | $3.06 |
| **Standard_NC16as_T4_v3**	| 16 |	110 |	360 |	T4 |	16 | ?  | 8000 | $1.20  |
| Standard_NV24s_v3 |	24 |	224 |	640 |	M60 |	16	| 40000/400 |	12000	| $2.28 |

NOTE: as of 3/2022: Google Colab Free uses K80 GPUs, Microsoft Planetary Computer and AWS Sagemaker Studio Lab use T4 GPUs

## References

* https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
* https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-gpu
* https://azuremarketplace.microsoft.com/en-us/marketplace/apps/nvidia.pytorch_from_nvidia?tab=PlansAndPrice
* https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension
* https://developer.nvidia.com/deep-learning-performance-training-inference
* https://timdettmers.com/2020/09/07/which-gpu-for-deep-learning/


## Troubleshooting

### Accessing Temp SSD storage
Temp storage (SSD) GiB is automatically mounted at `/mnt`, but you need to change permissions for non-root users: `sudo chmod -R a+w /mnt`*

### What ready-to-use machine images are available?
NOTE: NVIDIA provides free curated machine images, but you have to accept terms
to use them

`az vm image list --offer nvidia --all --output table`
#### tensorflow 
`az vm image terms accept  --urn nvidia:tensorflow_from_nvidia:ngc-tensorflow-version-20-08-1:20.08.1`

`az vm create --resource-group myResourceGroup --name myVM --image nvidia:tensorflow_from_nvidia:ngc-tensorflow-version-20-08-1:20.08.1  --location westus --size Standard_NC6s_v3`

#### pytorch
`az vm image show --location westus --urn nvidia:pytorch_from_nvidia:ngc-pytorch-version-21-11-0:21.11.0`

`az vm image terms accept --urn nvidia:pytorch_from_nvidia:ngc-pytorch-version-21-11-0:21.11.0`

#### Run Python for tensorflow/pytorch
The packages exist as docker images. To list images available in the vm:
`docker image ls`

`docker run --gpus all --rm -it nvcr.io/nvidia/tensorflow:20.07-tf2-py3`


### Mount an Azure File Share drive
https://github.com/Denolle-Lab/azure/tree/main/azure_file_share_data#linux-terminal

### How many of a particular VM can I run at a time?
https://portal.azure.com/#blade/Microsoft_Azure_Capacity/UsageAndQuota.ReactView/Parameters/%7B%22subscriptionId%22%3A%229630d625-8e9f-445e-acd8-85b3083e766e%22%2C%22selectedRps%22%3A%5B%22Microsoft.Compute%22%5D%2C%22defaultTitleSubscriptionName%22%3A%22Microsoft%20Azure%20Sponsorship%202%22%7D

### Run a script at startup
http://hypernephelist.com/2019/06/25/azure-vm-custom-script-extensions-with-terraform.html

### References
* https://docs.nvidia.com/ngc/ngc-deploy-public-cloud/ngc-azure/index.html
* https://docs.microsoft.com/en-us/azure/virtual-machines/linux/cli-ps-findimage
* https://docs.nvidia.com/ngc/ngc-azure-setup-guide/running-containers.html#running-containers
