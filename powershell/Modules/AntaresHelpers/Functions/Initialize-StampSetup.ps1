function Initialize-StampSetup(){
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$StampName,
        
        [string]$GeoRegion = "West US",
        [string]$Subscription = "exp-subscription",
        [string]$Webspace = "exp-linux-webspace",
        [string]$UserName = "visaayir",
        [string]$AntaresCmdPath = "C:/wagit/AAPT-Antares-WebSites/out/debug-amd64/hosting/Azure/RDTools/Tools/Antares/AntaresCmd.exe",
        [string]$AzureRdpPath = "C:/wagit/AAPT-Antares-WebSites/out/debug-amd64/hosting/Azure/RDTools/Tools/Antares/AzureRDP.exe",
        [string]$LocalDevEnvironmentStampConfigPath = "C:/wagit/Scripts/STAMPCONFIG/",
        [string]$LocalDevEnvironmentStampWebsitesDirectory = "D:/websites/",
        [Switch]$DisableLocalDevEnvironment
    ) 
    Write-Host ""    
    Add-BorderAroundText "Setting up the environment variables needed" 100
    Write-Host "Updating current stamp name to $Stampname"
    [Environment]::SetEnvironmentVariable("stampname", "$Stampname", "User")

    Write-Host "Setting AntaresCmd.exe path to $AntaresCmdPath"
    [Environment]::SetEnvironmentVariable("antarescmdpath", "$AntaresCmdPath", "User")
    
    Write-Host "Setting AzureRdp.exe path to $AzureRdpPath"
    [Environment]::SetEnvironmentVariable("AzureRdpPath", "$AzureRdpPath", "User")

    Write-Host "Setting Local Stamp config path to $LocalDevEnvironmentStampConfigPath"
    [Environment]::SetEnvironmentVariable("AntaresStampConfigPath", "$LocalDevEnvironmentStampConfigPath", "User")

    Write-Host "Setting Local Stamp Websites directory to $LocalDevEnvironmentStampWebsitesDirectory"
    [Environment]::SetEnvironmentVariable("AntaresStampWebsitesDirectory", "$LocalDevEnvironmentStampWebsitesDirectory", "User")

    New-User -UserName $UserName -PassKey $StampName
    New-Subscription -UserName $UserName -SubscriptionName $Subscription
    New-Webspace -SubscriptionName $Subscription -WebspaceName $Webspace -GeoRegionName $GeoRegion 

    New-StampConfigDirectory -LocalStampConfigPath $LocalDevEnvironmentStampConfigPath

    Get-WslStampConfig

    $stampconfig = [PSCustomObject]@{
        Name            = $StampName
        GeoRegion       = $GeoRegion
        Subscription    = $Subscription
        WebSpace        = $Webspace
        User            = $UserName
        Password        = $StampName
        Sites           = @(
            "defaultsite"
        )
    }
    
    $stampconfig | ConvertTo-Json | Out-File "$LocalDevEnvironmentStampConfigPath/$stampname.json"    

    New-AppServicePlan -SubscriptionName $Subscription -WebspaceName $Webspace -AppServicePlanName "default-asp" -WorkerSize 2
}