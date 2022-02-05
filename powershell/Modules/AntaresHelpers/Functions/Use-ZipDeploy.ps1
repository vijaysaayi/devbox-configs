function Use-ZipDeploy(){
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$PackagePath,
        
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$SiteName,
        [switch]$UseAsync
    ) 

    $stampName = [Environment]::GetEnvironmentVariable("stampname", "User");
    $stampConfigPath = [Environment]::GetEnvironmentVariable("AntaresStampConfigPath", "User");
    $stampConfig = Get-Content "$stampConfigPath/$stampName.json" | Out-String | ConvertFrom-Json
    $user = $stampConfig.User
    $password = $stampConfig.Password
    $url = "https://$SiteName.scm.$stampName.antares-test.windows-int.net/api/zipdeploy"
    
    if($UseAsync){        
        $url = $url + "?isAsync=true"
        Write-Host "$url"
    }
    
    curl -k -X POST -u "${user}:$password" -T "$PackagePath" $url -v

    Write-Host ""
    Write-Host "--------------------------------------------"
    Write-Host "  Zip Deploy Completed"
    Write-Host "--------------------------------------------"
    Write-Host "To browse to webapp, browse to http://$SiteName.$stampName.antares-test.windows-int.net/"
    Write-Host "To review the logs, browse to http://$SiteName.scm.$stampName.antares-test.windows-int.net/deploymentlogs/"
    

}