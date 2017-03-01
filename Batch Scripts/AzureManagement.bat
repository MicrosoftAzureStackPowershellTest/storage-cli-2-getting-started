rem Azure Storage Management Sample - Demonstrates how to create and manage storage accounts.
rem For more documentation, refer to http://go.microsoft.com/fwlink/?LinkId=786322
rem For the Azure CLI reference, see http://go.microsoft.com/fwlink/?LinkId=786325

rem Provide your subscription ID
rem To retrieve your subscription ID, run the following two commands:
  rem azure login
  rem azure account list
set subscription_id=<Subscription ID>

rem Provide the name of the resource group that will be created.
set resource_group_name=<Resource Group Name>

rem Provide the name of the Storage account that will be created.
set storage_account_name=<Storage Account Name>

rem Specify the SKU of the Storage account to create and another type that will be used for updating the Storage account. Valid values are:
  rem Premium_LRS,
  rem Standard_GRS
  rem Standard_LRS
  rem Standard_RAGRS,
  rem Standard_ZRS
set sku="Standard_LRS"
set new_sku="Standard_GRS"

rem Specify the location of the Storage account to create.
rem To view available locations for Storage, go to http://go.microsoft.com/fwlink/?LinkId=786652 or run the following command:
  rem azure provider show Microsoft.Storage
rem NOTE: Location names must be lowercase with no spaces. For example, East US = eastus.
set location=<Location>

echo "1. Set default Azure subscription."
call az account set --subscription %subscription_id%

echo "2. Create new resource group."
call az group create -n %resource_group_name% -l %location%

echo "3. Create new Storage account."
call az storage account create --resource-group %resource_group_name% --location %location% --sku %sku% -n %storage_account_name%

echo "4. Show details of Storage account."
call az storage account show --resource-group %resource_group_name% -n %storage_account_name%

echo "5. List all Storage accounts in subscription."
call az storage account list

echo "6. Get access keys for Azure Storage account."
call az storage account keys list --resource-group %resource_group_name% -n %storage_account_name%

echo "7. Renew primary access key for Azure Storage account."
call az storage account keys renew --resource-group %resource_group_name% --primary -n %storage_account_name%

echo "8. Print Azure Storage connection string."
call az storage account show connectionstring --resource-group %resource_group_name% -n %storage_account_name%

echo "9. Update Storage account type."
call az storage account set --resource-group %resource_group_name% --sku %new_sku% -n %storage_account_name%
call az storage account show --resource-group %resource_group_name% -n %storage_account_name%

echo "10. Delete Storage account."
call az storage account delete --resource-group %resource_group_name% -n %storage_account_name%

echo "12. Delete resource group."
call az group delete -n %resource_group_name%

echo "Done"
