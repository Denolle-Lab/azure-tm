# Run a Docker Container on Azure

* Mount a persistant network drive to the [Azure Container Instance](https://azure.microsoft.com/en-us/services/container-instances/#overview)
* This let's you run a Docker container with attached storage that can be used on other machines
* Optionally attach a GPU

⚠️ NOTE: Limitations! While this is an easy way to run containers, you are limited in terms of computational resources compared to running your own virtual machines or azure kubernetes service (https://docs.microsoft.com/en-us/azure/container-instances/container-instances-quotas)

💡 NOTE: Name your workspace something informative! All Cloud resources will appear under an Azure Resource Group with the workspace name ("scottGPU" in the example below"):

👀 NOTE: You can add a separate variable file instead of using the default `terraform.tfvars`. This is helpful for storing multiple configurations for other lab members to see and not interfere with version control. Just remember to point to it when you use `terraform apply -var-file="scottGPU.tfvars"`

```
terraform init
terraform workspace new scottGPU
terraform apply
```

After ~5 minutes you should see the URL output to connect to:
```
azurerm_container_group.example: Creation complete after 5m4s
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

jupyterlab_url = "seisbench.westus2.azurecontainer.io:8888/lab?token=539fc939473799f6570b68e69f9e82eefe473cc60d2408b3196adf609f9a0661"
```

Remove resources when finished
```
terraform destroy
```


## References

* https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group
* https://docs.microsoft.com/en-us/azure/container-instances/container-instances-gpu


## Troubleshooting


### Incorrect resource requests
```
Error: creating/updating Container Group: (Name "seisbench-container" / Resource Group "seisbench-resources"): containerinstance.ContainerGroupsClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: autorest/azure: Service returned an error. Status=<nil> Code="ServiceUnavailable" Message="The requested resource is not available in the location 'westus2' at this moment. Please retry with a different resource request or in another location. Resource requested: '4' CPU '32' GB memory 'Linux' OS"
```

**Solution**
Make sure you request <16GB RAM and <4CPU,

### Need to request quota increases for GPU resources

(default for P100 or V100 GPUs = 0)
```
 Error: creating/updating Container Group: (Name "scott-container" / Resource Group "default"): containerinstance.ContainerGroupsClient#CreateOrUpdate: Failure sending request: StatusCode=400 -- Original Error: Code="ContainerGroupQuotaReached" Message="Resource type 'Microsoft.ContainerInstance/containerGroups' container group quota 'P100Cores' exceeded in region 'westus2'. Limit: '0', Usage: '0' Requested: '1'."
```

**Solution**
https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest

### Super long startup time

Not sure how to get around this, but it can take a really long time to start when using a GPU (20 min!)
```
azurerm_container_group.example: Still creating... [20m40s elapsed]
azurerm_container_group.example: Creation complete after 20m41s [id=/subscriptions/9630d625-8e9f-445e-acd8-85b3083e766e/resourceGroups/default/providers/Microsoft.ContainerInstance/containerGroups/scott-container]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```
