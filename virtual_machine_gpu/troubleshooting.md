Error: waiting for creation of Linux Virtual Machine: (Name "scott-NCv3-vm" / Resource Group "scott-NCv3-resources"): Code="VMMarketplaceInvalidInput" Message="Creating a virtual machine from Marketplace image or a custom image sourced from a Marketplace image requires Plan information in the request. VM: '/subscriptions/9630d625-8e9f-445e-acd8-85b3083e766e/resourceGroups/scott-NCv3-resources/providers/Microsoft.Compute/virtualMachines/scott-NCv3-vm'


 Error: creating Linux Virtual Machine: (Name "scott-NCv3-vm" / Resource Group "scott-NCv3-resources"): compute.VirtualMachinesClient#CreateOrUpdate: Failure sending request: StatusCode=400 -- Original Error: Code="ResourcePurchaseValidationFailed" Message="User failed validation to purchase resources. Error message: 'You have not accepted the legal terms on this subscription: '9630d625-8e9f-445e-acd8-85b3083e766e' for this plan. Before the subscription can be used, you need to accept the legal terms of the image. To read and accept legal terms, use the Azure CLI commands described at https://go.microsoft.com/fwlink/?linkid=2110637 or the PowerShell commands available at https://go.microsoft.com/fwlink/?linkid=862451. Alternatively, deploying via the Azure portal provides a UI experience for reading and accepting the legal terms. Offer details: publisher='nvidia' offer = 'pytorch_from_nvidia', sku = 'ngc-pytorch-version-21-11-0', Correlation Id: 'a2f7daa3-73a1-6c26-3e42-6bebf5440d98'.'"

Run script at startup
https://stackoverflow.com/questions/54088476/terraform-azurerm-virtual-machine-extension


Very limited disk space!
NoSpaceLeftError: No space left on devices.

adminuser@scott-NCv3-vm:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        31G   31G     0 100% /

(~10GB? mostly gets filled up by mambaforge + single environement)
