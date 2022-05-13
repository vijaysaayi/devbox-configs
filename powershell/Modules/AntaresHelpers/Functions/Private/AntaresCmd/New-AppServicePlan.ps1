function New-AppServicePlan {
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
        [string]$AppServicePlanName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [int]$WorkerSize
    ) 
    
    $antarates_cmd = [Environment]::GetEnvironmentVariable("antarescmdpath", "User");
    Write-Host ""
    Add-BorderAroundText "Creating new App Service Plan with the name $AppServicePlanName" 100
    Write-Host "$antarates_cmd CreateServerFarm $SubscriptionName $WebSpaceName $AppServicePlanName /sku:Standard /UseCsm:false /isLinux:true /workerSize:$WorkerSize"
    "$antarates_cmd CreateServerFarm $SubscriptionName $WebSpaceName $AppServicePlanName /sku:Standard /UseCsm:false /isLinux:true /workerSize:$WorkerSize" | Invoke-Expression    
    
}