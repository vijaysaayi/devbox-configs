function Remove-AppService(){
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
    # Write-Host "+---------------------------------------------------------------------------------------+"
    # Write-Host "| This script will remove App Service $SiteName in private stamp $stampName             |"
    # Write-Host "+---------------------------------------------------------------------------------------+"
    Add-BorderAroundText "This script will remove App Service $SiteName in private stamp $stampName" 100
    "$antarates_cmd DeleteWebSite $subscription $webspace $SiteName " | Invoke-Expression    
        
}