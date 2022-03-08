function Update-CustomStartupCommand {
    [CmdletBinding()]
    param (           
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$SiteName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$CustomStartupCommand
    ) 
    
    $stampName = [Environment]::GetEnvironmentVariable("stampname", "User");
    $stampConfigPath = [Environment]::GetEnvironmentVariable("AntaresStampConfigPath", "User");
    $stampConfig = Get-Content "$stampConfigPath/$stampName.json" | Out-String | ConvertFrom-Json
    $subscription = $stampConfig.Subscription
    $webspace = $stampConfig.WebSpace
    $antarates_cmd = [Environment]::GetEnvironmentVariable("antarescmdpath", "User");

    Write-Host ""
    Add-BorderAroundText "Updating Custom startup command of App Service $SiteName" 100
    $quote = '"'
    $command = "$antarates_cmd UpdateWebSiteConfig $subscription $webspace $SiteName /appCommandLine:$quote$CustomStartupCommand$quote"
    Write-Debug "$command"
    Invoke-Expression $command
}