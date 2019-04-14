# Azure-PowerShell

## Install Azure PowerShell (as admin)
- Install-Module -Name Az -AllowClobber

## If AzureRm is already installed, remove (as admin)
- Uninstall-AzureRm

## Login to Azure from PowerShell (run and follow prompts)
- Connect-AzAccount

## List Resource Groups
- Get-AzResourceGroup

## List Resources
- Get-AzResource

## List Storage Accounts
- Get-AzStorageAccount
- Get-AzStorageAccount -ResourceGroupName "*resourceGroupName*" -Name "*storageAccountName*"

## Remove an Azure Resource (replace ... within quotes with the actual Id from the output of the command above)
- Remove-AzResource -ResourceId "..."

## Create a resource
- New-AzResource -ResourceType "" -ResourceGroupName "" -ResourceName "" -Location "East US" -Properties 

### i.e. Create a CosmosDB Resource
- $locations = @(@{"locationName"="East US"; "failoverPriority"=0}, @{"locationName"="West US"; "failoverPriority"=1})
- $consistencyPolicy = @{"defaultConsistencyLevel"="BoundedStaleness"; "maxIntervalInSeconds"="5"; maxStalenessPrefix"="100"}
- $iprangefilter = ""
- $CosmosDBProperties = @{"databaseAccountOfferType"="Standard"; "locations"=$locations; "consistencyPolicy"=$consistencyPolicy; "ipRangeFilter"=$iprangefilter}
- New-AzResource -ResourceType "Microsoft.DocumentDb/databaseAccounts" -ResourceGroupName ""
