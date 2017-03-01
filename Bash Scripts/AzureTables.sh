#!/usr/bin/env bash

# Azure Table Service Sample - Demonstrates how to perform common tasks using the Microsoft Azure Table storage
# including creating, listing, and deleting tables.
# For more documentation, refer to http://go.microsoft.com/fwlink/?LinkId=786322
# For the Azure CLI reference, refer to http://go.microsoft.com/fwlink/?LinkId=786325

# Provide the name of your Storage account.
export AZURE_STORAGE_ACCOUNT="<StorageAccountName>"

# Provide your Storage account key.
export AZURE_STORAGE_KEY="<StorageAccountKey>"

export SAS_EXPIRY=$(date --utc +%FT%TZ) 

# Provide a name for your new table.
table_name="<TableName>"

printf "\n1. Create a new table.\n"
az storage table create -n $table_name

printf "\n2. Generate read only SAS token for the table created\n"
az storage table generate-sas --permissions "r" --expiry $SAS_EXPIRY -n $table_name

printf "\n3. Insert an entity\n"
az storage entity insert -t $table_name --entity RowKey=key PartitionKey=key name=value

printf "\n4. Delete an entity\n"
az storage entity delete -t $table_name --partition-key "key" --row-key "key" 

printf "\n5. List all tables.\n"
az storage table list --output table

printf "\n6. Remove table\n"
az storage table delete -n $table_name

printf "\nDone\n\n"
