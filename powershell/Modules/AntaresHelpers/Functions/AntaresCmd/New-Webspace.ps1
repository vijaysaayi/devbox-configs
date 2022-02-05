function New-Webspace {
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
        [string]$GeoRegionName
    ) 
    $stampName = [Environment]::GetEnvironmentVariable("stampname", "User");
    $antarates_cmd = [Environment]::GetEnvironmentVariable("antarescmdpath", "User");
    Write-Host ""    
    Write-Host "---------------------------------------------------------------------------"
    Write-Host "Creating new Webspace : $WebSpaceName"
    Write-Host "---------------------------------------------------------------------------"
    "$antarates_cmd CreateWebSpace $SubscriptionName $WebSpaceName VirtualDedicatedPlan /geoRegion:'$GeoRegionName' /UseCsm:false /stampName:$stampName" | Invoke-Expression
}