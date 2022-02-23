# Azure file share

Network-attachable hard drive for data storage. The idea is to have a large drive
that you can easily mount either to local computers or cloud virtual machines.

Performance probably not as good as a local SSD, but should still be pretty fast.

You can use this drive with other services like Azure Batch or Container Instances

## Usage
```
terraform init
terraform apply
```

## Mount on local computer
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
