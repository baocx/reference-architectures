Write-Host "Make sure you have run 'az login' before using this script!"

# Asks resource group, location and admin password to use
$resource_group = Read-Host "Enter the resource group (Ex: n-tier-windows-rg)"
$location = Read-Host "Enter the location (Ex: eastus)"
$admin_password_sec = Read-Host "Enter the password to use for the admin user (12 chars, mixed case, digits and symbols)" -AsSecureString
$admin_password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($admin_password_sec))

# Create the resource group (if needed)
az group create --name $resource_group --location $location

# Deploys the RA
$(Get-Content -Path 'n-tier-windows.parameters.json') -replace '_admin_password_', $admin_password | Set-Content -Path 'parameters.json'
az deployment group create --resource-group $resource_group --template-file n-tier-windows.json --parameters parameters.json

# Asks for witness storage account information 
Write-Host "The first part of the deployment is complete!"
Write-Host "Open the Azure portal and navigate to the resource group. Find the storage account that begins with 'sqlcw'."
Write-Host "This is the storage account that will be used for the cluster's cloud witness."
Write-Host "Navigate into the storage account, select Access Keys, and copy the value of key1 and the storage account."
$storage_account_name = Read-Host "Enter the storage account name"
$storage_account_key_sec = Read-Host "Enter the storage account key" -AsSecureString
$storage_account_key = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($storage_account_key_sec))

# Installs SQL
$(Get-Content -Path 'n-tier-windows-sqlao.parameters.json') -replace '_admin_password_', $admin_password -replace '_storage_account_name_', $storage_account_name -replace '_storage_account_key_', $storage_account_key | Set-Content -Path 'parameters.json'
az deployment group create --resource-group $resource_group --template-file n-tier-windows-sqlao.json --parameters parameters.json

# Clean sensitive data
Remove-Item 'parameters.json'
$admin_password = ''
$storage_account_key = ''
