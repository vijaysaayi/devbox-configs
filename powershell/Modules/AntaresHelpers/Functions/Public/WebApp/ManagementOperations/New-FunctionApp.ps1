function New-FunctionApp(){
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

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

    $linuxFxVersion, $stack, $stackVersion = Get-LinuxFxVersion
    
    $subscription = $stampConfig.Subscription
    $webspace = $stampConfig.WebSpace

    if($CreateNewAppServicePlan){
        New-AppServicePlan -SubscriptionName $subscription -WebspaceName $webspace -AppServicePlanName $AppServicePlanName -WorkerSize $WorkerSize
    }
    New-LinuxFunctionApp -SubscriptionName $subscription -WebspaceName $webspace -FunctionAppName $Name -AppServicePlanName  $AppServicePlanName -Stack "$stack".ToLower()
    Update-AppSettings -SiteName $Name -Name "FUNCTIONS_EXTENSION_VERSION" -Value "~3"
    Update-AppSettings -SiteName $Name -Name "FUNCTIONS_WORKER_RUNTIME" -Value "$stack".ToLower()
    Update-SiteConfig -SubscriptionName $subscription -WebspaceName $webspace -WebAppName $Name -LinuxFxVersion $linuxFxVersion

    $stampConfig.Sites += $Name
    $stampConfigPath = [Environment]::GetEnvironmentVariable("AntaresStampConfigPath", "User");
    $stampconfig | ConvertTo-Json | Out-File "$stampConfigPath/$stampName.json"

    if(!$DisableLocalDevEnvironment){
        Update-DevEnvironmentForNewWebApp -SiteName $Name -RemainInSameDirectory $RemainInSameDirectory
    }

}