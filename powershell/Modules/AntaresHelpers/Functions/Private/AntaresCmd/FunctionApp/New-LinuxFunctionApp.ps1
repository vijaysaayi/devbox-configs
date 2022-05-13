function New-LinuxFunctionApp {
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
        [string]$FunctionAppName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$AppServicePlanName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Stack
    ) 
    
    $antarates_cmd = [Environment]::GetEnvironmentVariable("antarescmdpath", "User");
    Write-Host ""
    Add-BorderAroundText "Creating new Function App - $FunctionAppName" 100
    "$antarates_cmd CreateFunctionSite $SubscriptionName $WebSpaceName $FunctionAppName /isLinux:true /serverFarm:$AppServicePlanName /UseCsm:false" | Invoke-Expression    
        
}