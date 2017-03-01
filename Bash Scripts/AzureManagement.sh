# Azure Storage Management Sample - Demonstrates how to create and manage storage accounts.
# For more documentation, refer to http://go.microsoft.com/fwlink/?LinkId=786322
# For the Azure CLI reference, see http://go.microsoft.com/fwlink/?LinkId=786325

# Provide your subscription ID
# To retrieve your subscription ID, run the following two commands:
  # az login
  # az account list
subscription_id="<SubscriptionID>"

# Provide the name of the resource group that will be created.
resource_group_name="<ResourceGroupName>"

# Provide the name of the Storage account that will be created.
storage_account_name="<AccountName>"

# Specify the SKU of the Storage account to create and another type that will be used for updating the Storage account. Valid values are:
  # Premium_LRS,
  # Standard_GRS
  # Standard_LRS
  # Standard_RAGRS,
  # Standard_ZRS
sku="Standard_LRS"
new_sku="Standard_GRS"

# Specify the location of the Storage account to create.
# To view available locations for Storage, go to http://go.microsoft.com/fwlink/?LinkId=786652 or run the following command:
  # azure provider show Microsoft.Storage
#NOTE: Location names must be lowercase with no spaces. For example, East US = eastus.
location="<Location>"

printf "\n1. Set default Azure subscription.\n"
az account set --subscription $subscription_id

printf "\n2. Create new resource group.\n"
az group create -n $resource_group_name -l $location

printf "\n3. Create new Storage account.\n"
az storage account create --resource-group $resource_group_name --location $location --sku $sku -n $storage_account_name

printf "\n4. Show details of Storage account.\n"
az storage account show --resource-group $resource_group_name -n $storage_account_name

printf "\n5. List all Storage accounts in subscription.\n"
az storage account list --output table

printf "\n6. Get access keys for Azure Storage account.\n"
az storage account keys list --resource-group $resource_group_name -n $storage_account_name --output table

printf "\n7. Renew primary access key for Azure Storage account.\n"
az storage account keys renew --resource-group $resource_group_name --key primary -n $storage_account_name

printf "\n8. Export Azure Storage connection string.\n"
export AZURE_STORAGE_CONNECTION_STRING=$(az storage account show-connection-string --resource-group $resource_group_name -n $storage_account_name -o tsv)
echo $AZURE_STORAGE_CONNECTION_STRING

printf "\n9. Update Storage account type.\n"
az storage account update --resource-group $resource_group_name --sku $new_sku -n $storage_account_name
az storage account show --resource-group $resource_group_name -n $storage_account_name

printf "\n10. Delete Storage account.\n"
az storage account delete --resource-group $resource_group_name -n $storage_account_name

printf "\n11. Delete resource group.\n"
az group delete -n $resource_group_name

printf "\nDone\n\n"
