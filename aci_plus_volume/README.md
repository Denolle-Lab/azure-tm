# Run a Docker Container on Azure

Mount a persistant network drive to the Azure Container Instance

```
terraform init
# Name your workspace something informative:
terraform workspace new scott
terraform apply
```

After ~5 minutes you should see the URL output to connect to
```
azurerm_container_group.example: Creation complete after 5m4s
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

jupyterlab_url = "seisbench.westus2.azurecontainer.io:8888/lab?token=539fc939473799f6570b68e69f9e82eefe473cc60d2408b3196adf609f9a0661"
```

## Troubleshooting

│ Error: creating/updating Container Group: (Name "seisbench-container" / Resource Group "seisbench-resources"): containerinstance.ContainerGroupsClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: autorest/azure: Service returned an error. Status=<nil> Code="ServiceUnavailable" Message="The requested resource is not available in the location 'westus2' at this moment. Please retry with a different resource request or in another location. Resource requested: '4' CPU '32' GB memory 'Linux' OS"


**Solution**
Make sure you request <16GB RAM and <4CPU
