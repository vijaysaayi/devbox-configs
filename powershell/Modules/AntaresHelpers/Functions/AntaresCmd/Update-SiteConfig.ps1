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
        [string]$LinuxFxVersion
    ) 
    
    $antarates_cmd = [Environment]::GetEnvironmentVariable("antarescmdpath", "User");
    Write-Host ""
    Write-Host "---------------------------------------------------------------------------"
    Write-Host "Update the Site config"
    Write-Host "---------------------------------------------------------------------------"
    $quote = '"'
    $command = "$antarates_cmd UpdateWebSiteConfig $SubscriptionName $WebSpaceName $WebAppName /UseCsm:false /alwaysOn:1 /linuxFxVersion:$quote$LinuxFxVersion$quote"
    Write-Host "$command"
    Invoke-Expression $command
}