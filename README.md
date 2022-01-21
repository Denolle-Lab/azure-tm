# Azure

Goal: Spin up Cloud resources on Azure using credits.

We'll use [Terraform](https://www.terraform.io), for reproducibility and easy tracking of resources
https://docs.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash

## Set up local environment
```
conda env create
conda activate azure
```

## Authenticate to Azure via a Microsoft account
```
az login
```

## confirm
`az account show`
