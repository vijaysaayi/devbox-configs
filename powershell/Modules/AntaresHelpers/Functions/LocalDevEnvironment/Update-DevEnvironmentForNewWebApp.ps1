function Update-DevEnvironmentForNewWebApp {
    [CmdletBinding()]
    param (           
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$SiteName,

        [bool]$RemainInSameDirectory
    )     
    
    
    $stampName = [Environment]::GetEnvironmentVariable("stampname", "User");
    $localWebSitesDirectory = [Environment]::GetEnvironmentVariable("AntaresStampWebsitesDirectory", "User");
    $stampDirectory = "$localWebSitesDirectory/$stampName"
    $stampConfigPath = [Environment]::GetEnvironmentVariable("AntaresStampConfigPath", "User");
    
    Write-Host ""
    Write-Host "--------------------------------------------------------------------------------------------"
    Write-Host "Setting up a directory in local machine which can help with code deployments"
    Write-Host "--------------------------------------------------------------------------------------------"
    Write-Host "Creating directory for stamp : $stampDirectory, if it doesn't exist"
    [System.IO.Directory]::CreateDirectory($stampDirectory)
    $siteDir = [IO.Path]::Combine($stampDirectory , $SiteName )
    Write-Host ""
    Write-Host "Creating directory for website $siteDir, if it doesn't exist"
    [System.IO.Directory]::CreateDirectory($siteDir)

    Write-Host ""
    Write-Host "Creating directory for website.backup $siteDir.backup, if it doesn't exist"
    [System.IO.Directory]::CreateDirectory("$siteDir.backup")
    Write-Host ""
    Write-Host "Cleaning existing $siteName.backup directory"
    Remove-Item "$siteDir.backup\*.*" -Recurse -Force
    Write-Host "Copying files from $siteDir to $siteDir.backup"
    Move-Item -Path "$siteDir\*" -Destination "$siteDir.backup"
    Write-Host "Cleaning site Directory"
    Remove-Item "$siteDir\*.*" -Recurse -Force

    $currentDir = Get-Location
    Set-Location -Path $siteDir
    Write-Host ""
    Write-Host "Initalizing git in this folder"
    Invoke-Expression -Command "git init"

    $stampConfig = Get-Content "$stampConfigPath/$stampName.json" | Out-String | ConvertFrom-Json
    $user = $stampConfig.User
    $password = $stampConfig.Password
    $remoteUrl = "https://${user}:${password}@$SiteName.scm.$stampName.antares-test.windows-int.net/$SiteName.git"
    Write-Host "Setting up remote url for local git deployment"
    Invoke-Expression -Command "git remote add azure $remoteUrl"

    Write-Host ""
    Write-Host "--------------------------------------------------------------------------------------"
    Write-Host "Setup Completed. You can browse to Main site and Kudu site using the following links"
    Write-Host "--------------------------------------------------------------------------------------"        
    Write-Host "Main Site : http://$SiteName.$stampName.antares-test.windows-int.net"
    Write-Host "Kudu Site : http://$SiteName.scm.$stampName.antares-test.windows-int.net/newui"

    if($RemainInSameDirectory)
    {
        Set-Location -Path $currentDir
    }
}