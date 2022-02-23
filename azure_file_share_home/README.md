# Azure file share

network-attachable hard drive. Note this is used for persistant storage of files for a Jupyter server. \

The [../aci_container_instance](../aci_container_instance) configuration launches a server with this drive
mounted over `/home/jovyan` so that your files persist between sessions


## Usage
```
terraform init
terraform apply
```


NOTE: you can open this on a Mac terminal!
https://docs.microsoft.com/en-us/azure/storage/files/storage-how-to-use-files-mac

```
# connect to server ->
# smb://seisbench.file.core.windows.net/seisbench

# open smb://<storage-account-name>:<storage-account-key>@<storage-account-name>.file.core.windows.net/<share-name>

export STORAGE_ACCOUNT_KEY="I+XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=="
export STORAGE_ACCOUNT="seisbench"
export SHARE_NAME="seisbench"
open "smb://${STORAGE_ACCOUNT}:${STORAGE_ACCOUNT_KEY}@${STORAGE_ACCOUNT}.file.core.windows.net/${SHARE_NAME}
```

## References

https://docs.microsoft.com/en-us/azure/container-instances/container-instances-volume-azure-files
