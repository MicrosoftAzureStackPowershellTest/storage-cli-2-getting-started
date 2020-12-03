rem Azure Table Service Sample - Demonstrates how to perform common tasks using the Microsoft Azure Table storage
rem including creating, listing, and deleting tables.
rem For more documentation, refer to http://go.microsoft.com/fwlink/?LinkId=786322
rem For the Azure CLI reference, refer to http://go.microsoft.com/fwlink/?LinkId=786325

rem Provide the name of your Storage account.
set AZURE_STORAGE_ACCOUNT=testsa

rem Provide your Storage account key.
set AZURE_STORAGE_KEY=fdctxqHO3Imbn/qZ16A1x7NJKHZ0QSaytdaA7LO4QshdizKiwmCaNCr3vTj0+Hg5Ctq4kZLEVKX+10rVhmn/pg==

rem Provide a name for your new table.
set table_name=newtable

echo "1. Create a new table."
call az storage table create -n %table_name%

echo "2. Generate read only SAS token for the table created"
call az storage table generate-sas --permissions "r" --expiry 2018-01-01T00:00Z -n %table_name%

echo "3. Insert an entity"
call az storage entity insert -t %table_name% --entity RowKey=key PartitionKey=key name=value

echo "4. Delete an entity"
call az storage entity delete -t %table_name% --partition-key "key" --row-key "key" 

echo "2. List all tables."
call az storage table list

echo "3. Remove table"
call az storage table delete -n %table_name%

echo "Done"
