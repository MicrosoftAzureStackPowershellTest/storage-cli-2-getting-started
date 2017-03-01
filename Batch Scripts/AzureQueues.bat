rem Azure Queue Service Sample - The Queue Service provides reliable messaging for workflow processing and for communication
rem between loosely coupled components of cloud services. This sample demonstrates how to perform common tasks including
rem creating, listing, and deleting queues.
rem For more documentation, refer to http://go.microsoft.com/fwlink/?LinkId=786322
rem For the Azure CLI reference, refer to http://go.microsoft.com/fwlink/?LinkId=786325

rem Provide the name of your Storage account.
set AZURE_STORAGE_ACCOUNT=<StorageAccountName>

rem Provide your Storage account key.
set AZURE_STORAGE_KEY=<StorageAccountKey>

rem Provide a name for your new queue.
set queue_name=<Queue Name>

echo "1. Create a new queue."
call az storage queue create -n %queue_name%

echo "2. Show details of the queue."
call az storage queue metadata show -n %queue_name%

echo "3. Add a message to the queue"
call az storage message put -q %queue_name% --content "testmessage"

echo "4. Get message from the queue"
call az storage message get -q %queue_name%

echo "5. List all queues."
call az storage queue list --output table

echo "6. Remove queue"
call az storage queue delete -n %queue_name%

echo "Done"
