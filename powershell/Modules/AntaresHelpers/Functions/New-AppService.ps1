function New-AppService(){
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$SiteName,

        [string]$AppServicePlanName = "default-asp",
        [switch]$CreateNewAppServicePlan ,
        [int]$WorkerSize = 2,
        [Switch]$DisableLocalDevEnvironment,
        [switch]$RemainInSameDirectory
    ) 
        
    $stampName = [Environment]::GetEnvironmentVariable("stampname", "User");
    Write-Host "New App Service will be created in $stampName"; 

    $stampConfigPath = [Environment]::GetEnvironmentVariable("AntaresStampConfigPath", "User");
    $stampConfig = Get-Content "$stampConfigPath/$stampName.json" | Out-String | ConvertFrom-Json

    $stack = Get-LinuxFxVersion
    
    $subscription = $stampConfig.Subscription
    $webspace = $stampConfig.WebSpace

    if($CreateNewAppServicePlan){
        New-AppServicePlan -SubscriptionName $subscription -WebspaceName $webspace -AppServicePlanName $AppServicePlanName -WorkerSize $WorkerSize
    }
    New-LinuxWebApp -SubscriptionName $subscription -WebspaceName $webspace -WebAppName $SiteName -AppServicePlanName  $AppServicePlanName 
    Update-SiteConfig -SubscriptionName $subscription -WebspaceName $webspace -WebAppName $SiteName -LinuxFxVersion $stack

    $stampConfig.Sites += $SiteName
    $stampConfigPath = [Environment]::GetEnvironmentVariable("AntaresStampConfigPath", "User");
    $stampconfig | ConvertTo-Json | Out-File "$stampConfigPath/$stampName.json"

    if(!$DisableLocalDevEnvironment){
        Update-DevEnvironmentForNewWebApp -SiteName $SiteName -RemainInSameDirectory $RemainInSameDirectory
    }

}