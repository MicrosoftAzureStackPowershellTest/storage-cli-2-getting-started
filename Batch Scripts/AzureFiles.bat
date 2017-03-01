rem Azure Storage File Sample - Demonstrates how to use the File Storage service.
rem For more documentation, refer to http://go.microsoft.com/fwlink/?LinkId=786322
rem For the Azure CLI reference, refer to http://go.microsoft.com/fwlink/?LinkId=786325

set AZURE_STORAGE_ACCOUNT=<Storage Account Name>
set AZURE_STORAGE_KEY=<Storage Account Key>

set share_name=<Share Name>
set directory_name=<DirectoryName>
set file_name=<FileName>
set destination_file=<destination path>
set source_path=<LocalFilePath>

echo "Creating the file share..."
call az storage share create -n %share_name%

echo "Creating the directory..."
call az storage directory create -s %share_name% -n %directory_name%

echo "Uploading the file..."
call az storage file upload --source %full_path_to_file% -s %share_name% -p %directory_name%

echo "Listing the files and directories..."
call az storage file list -s %share_name% --output table
call az storage file list -s %share_name% -p %directory_name% --output table

echo "Downloading the file..."
set source_path=%directory_name%/%file_name%
call az storage file download -s %share_name% -p %source_path% --dest %destination_file%

echo "Deleting the share..."
call az storage share delete -n %share_name%

echo "Deleting the downloaded file..."
del %destination_file%

echo "Done"
