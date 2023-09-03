# This is not a login script
# This is a list of commands to login to Azure
# I wrote it to keep all commands it on one place for future use

# Login (this will open web browser and let me login)
Connect-AzAccount 

# List availabe subscirptions
Get-AzSubscription

# Select subscription for deployment
# $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
$context = Get-AzSubscription -subscriptionName "cloudzerotohero"
Set-AzContext $context
# just to check of command was successful
Get-AzContext    


# Commands to create service principal (once logged in to Azure with e.g. owner acoount)
$subscriptionID = (Get-AzSubscription -subscriptionName "cloudzerotohero").Id
## Create a service principal
$userName = "testuserx"
$sp = New-AzADServicePrincipal -DisplayName $userName
## obtain password (and keep it in safe place)
$sp.PasswordCredentials.SecretText
## verify what role is assigned to the service principal and what is the scope
Get-AzRoleAssignment -ObjectID $sp.Id | select DisplayName,RoleDefinitionName,Scope
## If necessary - assign contributor role
New-AzRoleAssignment -ObjectId $sp.Id -RoleDefinitionName "Contributor" -Scope "/subscriptions/$subscriptionID"

# Connect to Azure with previously created service principal

## Right after service principal was created (with commands above) use these
## Use the application ID as the username, and the secret as password
$User = $sp.AppId
$PWord = ConvertTo-SecureString -String $sp.PasswordCredentials.SecretText -AsPlainText -Force
$Tenant_ID = (Get-AzContext).Tenant.Id
$Credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

Connect-AzAccount -ServicePrincipal -Credential $credentials -Tenant $Tenant_ID

## Use these when login "norally" - when service principal was already created
## Use the application ID as the username, and the secret as password
$credentials = Get-Credential
$Tenant_ID = xxxx-xxxx-xxxx-xxxx
Connect-AzAccount -ServicePrincipal -Credential $credentials -Tenant $Tenant_ID


# When work is done, disconnect form Azure
Disconnect-AzAccount
