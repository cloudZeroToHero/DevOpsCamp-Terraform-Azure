# This is a list of commands to login to Azure
# Just to keep it on one place for future use

#Login
Connect-AzAccount

# List availabe subscirptions
Get-AzSubscription

# Select subscription for deployment
# $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
$context = Get-AzSubscription -subscriptionName "cloudzerotohero"
Set-AzContext $context
Get-AzContext    



# When work is done, disconnect form Azure
Disconnect-AzAccount
