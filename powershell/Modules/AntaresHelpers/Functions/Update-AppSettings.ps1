function Update-AppSettings(){
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$SiteName
    ) 
        
    $stampName = [Environment]::GetEnvironmentVariable("stampname", "User");
    $stampConfigPath = [Environment]::GetEnvironmentVariable("AntaresStampConfigPath", "User");
    $stampConfig = Get-Content "$stampConfigPath/$stampName.json" | Out-String | ConvertFrom-Json
    $subscription = $stampConfig.Subscription
    $webspace = $stampConfig.WebSpace
    $antarates_cmd = [Environment]::GetEnvironmentVariable("antarescmdpath", "User");

    Write-Host ""
    Add-BorderAroundText "This script will update App Settings of existing App Service in private stamp $stampName" 100
    do {
        $appSettingName =  Read-Host -p "App Setting Name"   
        $appSettingValue =  Read-Host -p "App Setting Value"   
        "$antarates_cmd AddWebSiteAppSettings $subscription $webspace $SiteName $appSettingName=$appSettingValue" | Invoke-Expression    
        
        $option, $optionIndex = New-Menu -Title "" -Question "Do you want to update another App Setting ?" -Options @("&Yes","&No") -DefaultOption 1
        
    } until ($optionIndex -eq 1)
}