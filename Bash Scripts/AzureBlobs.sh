#!/usr/bin/env bash

# Azure Storage Blob Sample - Demonstrates how to use the Blob Storage service.
# Blob storage stores unstructured data such as text, binary data, documents or media files.
# For more documentation, refer to http://go.microsoft.com/fwlink/?LinkId=786322
# For the Azure CLI reference, see http://go.microsoft.com/fwlink/?LinkId=786325

# Provide the name of your Storage account.
export AZURE_STORAGE_ACCOUNT="<StorageAccountName>"

# Provide your Storage account key.
export AZURE_STORAGE_KEY="<StorageAccountKey>"

# Provide a name for your new container.
container_name="<ContainerName>"

# Provide a name for your new blob.
blob_name="<BlobName>"

# Provide the full path to a file you want to upload.
file_to_upload="<LocalFilePath>"

# Provide the full path to a directory you wish to use for downloaded blobs.
destination_folder="<DownloadPath>"

printf "\n1. Create a new container.\n"
az storage container create -n $container_name

printf "\n2. Upload into a container.\n"
az storage blob upload -c $container_name -n $blob_name -f $file_to_upload

printf "\n3. List all blobs in a container.\n"
az storage blob list -c $container_name --query "[?properties.blobType=='BlockBlob'].name"

printf "\n4. List all blobs in a container (table) and retrieve the name of the blob.\n"
blob_to_download=$(az storage blob list -c $container_name --output table | tail -1 | awk '{print $1}')
echo $blob_to_download

printf "\n5. Iterate through the list result.\n"
for blob in $(az storage blob list -c $container_name -otsv --query "[?properties.blobType=='BlockBlob'].name"); do az storage blob show -n $blob -c $container_name; done

printf "\n6. Download blob.\n"
az storage blob download -c $container_name -f $destination_folder/$blob_name -n $blob_to_download

printf "\n7. Delete container.\n"
az storage container delete -n $container_name


printf "\nDone\n\n"
