# Connect to Azure
#Connect-AzAccount

# List Azure storage accounts currently exists
#Get-AzureStorageAccount

# List Azure Resource Groups currently exists
#Get-AzResourceGroup

# List locations
#Get-AzLocation | Select-Object Location

# Set variables
$resourceGroupName = ""
$location = "eastus"

# InitializeVeriables
$resourceGroups = ""
$storageAccounts = ""
$myError = ""

# Create a resource group if needed
$resourceGroups = Get-AzResourceGroup -ErrorAction SilentlyContinue -ErrorVariable myError | Select-Object ResourceGroupName
if ($myError)
{
    # No resource groups found
    Write-Host $myError -ForegroundColor Red -BackgroundColor Black    
    $myError = ""
    Write-Host "No resource groups found! Creating the resource group " $resourceGroupName " ..." -ForegroundColor Yellow -BackgroundColor Black
    New-AzResourceGroup -Name $resourceGroupName -Location $location
}
elseif ($resourceGroups -match $resourceGroupName) 
{
    # Skip creating the resource group
    Write-Host "Resource group " $resourceGroupName " already exists! Step skipped..." -ForegroundColor Yellow -BackgroundColor Black  
}
else
{
    Write-Host "Create the resource group " $resourceGroupName " ..."
    New-AzResourceGroup -Name $resourceGroupName -Location $location
}

# Create a storage account
$storageAccountName = ""
$storageSkuName = "Standard_LRS"
$storageKind = "StorageV2"
$storageAccounts = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -ErrorAction SilentlyContinue -ErrorVariable myError | Select-Object StorageAccountName
if ($myError)
{
    Write-Host $myError - -ForegroundColor Red -BackgroundColor Black
    Write-Host "No storage accounts found. Creating storage account " $storageAccountName " ..."
    $myError = ""
    New-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $location -SkuName $storageSkuName -Kind $storageKind -EnableHttpsTrafficOnly False
}
elseif ($storageAccounts -match $storageAccountName)
{
    Write-Host "Storage account " $storageAccountName " already exists!" -ForegroundColor Yellow -BackgroundColor Black
}
else {
    Write-Host "Creating storage account " $storageAccountName " ..."
    New-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $location -SkuName $storageSkuName -Kind $storageKind -EnableHttpsTrafficOnly False
}

# Done
Write-Host "This PowerShell script ran successfully! " $MyInvocation.ScriptName


