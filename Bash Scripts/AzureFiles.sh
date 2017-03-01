#!/usr/bin/env bash

# Azure Storage File Sample - Demonstrates how to use the File Storage service.
# For more documentation, refer to http://go.microsoft.com/fwlink/?LinkId=786322
# For the Azure CLI reference, refer to http://go.microsoft.com/fwlink/?LinkId=786325

# Provide the name of your Storage account.
export AZURE_STORAGE_ACCOUNT="<StorageAccountName>"

# Provide your Storage account key.
export AZURE_STORAGE_KEY="<StorageAccountKey>"

# Provide a name for your new share
share_name="<ShareName>"

# Provide a name for your new directory
directory_name="<DirectoryName>"

# Provide the full path to the file you want to upload.
full_path_to_file="<LocalFilePath>"

# Provide the name of the file. NOTE: This should be an exact match to the file name you've provided in full_path_to_file.
file_name="<LocalFileName>"

# Provide the full path for a new local directory
destination_path="<LocalDestinationPath>"
mkdir $destination_path

printf "\n1. Create a new share.\n"
az storage share create -n $share_name

printf "\n2. Create a new directory within the share.\n"
az storage directory create -s $share_name -n $directory_name

printf "\n3. Upload new file into directory.\n"
az storage file upload --source $full_path_to_file -s $share_name -p $directory_name

printf "\n4. List contents within share.\n"
az storage file list -s $share_name --query [*].[name,lastModified]
az storage file list -s $share_name --output table

printf "\n5. List contents within directory.\n"
file_to_download=$(az storage file list -s $share_name -p $directory_name --output table | tail -1 | awk '{print $1}')
echo $file_to_download

printf "\n.6 Download the file.\n"
az storage file download -s $share_name -p $directory_name/$file_to_download --dest $destination_path

printf "\n7. Delete the share.\n"
az storage share delete -n $share_name

printf "\nDone\n\n"
