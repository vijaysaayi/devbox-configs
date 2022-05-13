function New-LinuxWebApp {
    [CmdletBinding()]
    param (           
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$SubscriptionName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$WebspaceName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$WebAppName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$AppServicePlanName
    ) 
    
    $antarates_cmd = [Environment]::GetEnvironmentVariable("antarescmdpath", "User");
    Write-Host ""
    Add-BorderAroundText "Creating new App Service - $WebAppName" 100
    "$antarates_cmd CreateWebSite $SubscriptionName $WebSpaceName $WebAppName /computeMode:Dedicated /serverFarm:$AppServicePlanName /UseCsm:false" | Invoke-Expression    
        
}