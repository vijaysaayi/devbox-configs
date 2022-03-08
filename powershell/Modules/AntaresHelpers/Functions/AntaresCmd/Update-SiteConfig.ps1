function Update-SiteConfig {
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
        [string]$LinuxFxVersion,

        [string]$CustomStartupCommand=""
    ) 
    
    $antarates_cmd = [Environment]::GetEnvironmentVariable("antarescmdpath", "User");
    Write-Host ""
    Add-BorderAroundText "Updating LinuxFx Version to $LinuxFxVersion" 100
    $quote = '"'
    $command = "$antarates_cmd UpdateWebSiteConfig $SubscriptionName $WebSpaceName $WebAppName /UseCsm:false /alwaysOn:1 /linuxFxVersion:$quote$LinuxFxVersion$quote"
    if ($CustomStartupCommand -eq ""){
        $command = "$command /appCommandLine:$CustomStartupCommand"
    }
    Write-Host "$command"
    Invoke-Expression $command
}