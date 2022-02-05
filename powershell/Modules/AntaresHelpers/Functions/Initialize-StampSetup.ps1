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
        [string]$LocalDevEnvironmentStampConfigPath = "C:/wagit/Scripts/STAMPCONFIG/",
        [string]$LocalDevEnvironmentStampWebsitesDirectory = "D:/websites/",
        [Switch]$DisableLocalDevEnvironment
    ) 
    Write-Host ""    
    Write-Host "---------------------------------------------------------------------------"
    Write-Host "Setting up the environment variables needed"
    Write-Host "---------------------------------------------------------------------------" 
    Write-Host "Updating current stamp name to $Stampname"
    [Environment]::SetEnvironmentVariable("stampname", "$Stampname", "User")

    Write-Host "Setting AntaresCmd.exe path to $AntaresCmdPath"
    [Environment]::SetEnvironmentVariable("antarescmdpath", "$AntaresCmdPath", "User")

    Write-Host "Setting Local Stamp config path to $LocalDevEnvironmentStampConfigPath"
    [Environment]::SetEnvironmentVariable("AntaresStampConfigPath", "$LocalDevEnvironmentStampConfigPath", "User")

    Write-Host "Setting Local Stamp Websites direcctory to $LocalDevEnvironmentStampWebsitesDirectory"
    [Environment]::SetEnvironmentVariable("AntaresStampWebsitesDirectory", "$LocalDevEnvironmentStampWebsitesDirectory", "User")

    New-User -UserName $UserName -PassKey $StampName
    New-Subscription -UserName $UserName -SubscriptionName $Subscription
    New-Webspace -SubscriptionName $Subscription -WebspaceName $Webspace -GeoRegionName $GeoRegion 

    New-StampConfigDirectory -LocalStampConfigPath $LocalDevEnvironmentStampConfigPath

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