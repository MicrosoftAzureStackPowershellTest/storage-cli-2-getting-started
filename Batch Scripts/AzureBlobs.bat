rem Azure Storage Blob Sample - Demonstrates how to use the Blob Storage service.
rem Blob storage stores unstructured data such as text, binary data, documents or media files.
rem For more documentation, refer to http://go.microsoft.com/fwlink/?LinkId=786322
rem For the Azure CLI reference, see http://go.microsoft.com/fwlink/?LinkId=786325

rem Provide the name of your Storage account.
set AZURE_STORAGE_ACCOUNT=testsa

rem Provide your Storage account key.
set AZURE_STORAGE_KEY=fdctxqHO3Imbn/qZ16A1x7NJKHZ0QSaytdaA7LO4QshdizKiwmCaNCr3vTj0+Hg5Ctq4kZLEVKX+10rVhmn/pg==

rem Provide a name for your new container.
set container_name=container1

rem Provide a name for your new blob.
set blob_name=blob1

rem Provide the full path to a file you want to upload.
set file_to_upload=C:\azure-cli\README.md

rem Provide the full path to a directory you wish to use for downloaded blobs.
set destination_folder=D:

echo "1. Create a new container."
call az storage container create -n %container_name%

echo "2. Upload a blob into a container."
call az storage blob upload -f %file_to_upload% -c %container_name% -n %blob_name%

echo "3. List all blobs in a container with query."
call az storage blob list -c %container_name% --query "[?properties.blobType=='BlockBlob'].name"

echo "4. List all blobs in a container."
call az storage blob list -c %container_name% --output table

echo "5. Download blob."
call az storage blob download -c %container_name% -n %blob_name% -f %destination_folder%

echo "6. Delete container"
call az storage container delete -n %container_name%

echo "Done"
