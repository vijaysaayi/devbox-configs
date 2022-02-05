function New-Subscription {
    [CmdletBinding()]
    param (           
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$SubscriptionName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$UserName
    ) 
    
    $antarates_cmd = [Environment]::GetEnvironmentVariable("antarescmdpath", "User");
    Write-Host ""
    Write-Host "---------------------------------------------------------------------------"
    Write-Host "Creating new subscription : $SubscriptionName"
    Write-Host "---------------------------------------------------------------------------"
    Write-Host "Adding user $UserName as owner of subscription $SubscriptionName"
    "$antarates_cmd CreateSubscription $SubscriptionName /ownerUserName:$UserName /description:test /UseCsm:false" | Invoke-Expression 
}