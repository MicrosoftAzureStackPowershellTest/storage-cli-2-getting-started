#!/usr/bin/env bash

# Azure Queue Service Sample - The Queue Service provides reliable messaging for workflow processing and for communication
# between loosely coupled components of cloud services. This sample demonstrates how to perform common tasks including
# creating, listing, and deleting queues.
# For more documentation, refer to http://go.microsoft.com/fwlink/?LinkId=786322
# For the Azure CLI reference, refer to http://go.microsoft.com/fwlink/?LinkId=786325

# Provide the name of your Storage account.
export AZURE_STORAGE_ACCOUNT="<StorageAccountName>"

# Provide the your Storage account key.
export AZURE_STORAGE_KEY="<StorageAccountKey>"

# Provide a name for your new queue.
queue_name="<QueueName>"

printf "\n1. Create a new queue.\n"
az storage queue create -n $queue_name

printf "\n2. Show metadata of the queue.\n"
az storage queue metadata show -n $queue_name

printf "\n3. Add Message.\n"
az storage message put -q $queue_name --content "testmessage"

printf "\n4. Get message from the queue.\n"
az storage message get -q $queue_name 

printf "\n5. List all queues.\n"
az storage queue list

printf "\n6. Delete queue.\n"
az storage queue delete -n $queue_name

# Remove environment variables
unset AZURE_STORAGE_ACCOUNT
unset AZURE_STORAGE_ACCESS_KEY

printf "\nDone\n\n"
