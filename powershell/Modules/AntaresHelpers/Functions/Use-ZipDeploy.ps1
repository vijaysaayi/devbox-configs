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
    
    $quote='"'
    $command = "curl -k -X POST --header 'Content-Type: application/zip' -u ${quote}${user}:$password${quote} --data-binary ${quote}$PackagePath${quote} $url -v" 
    Write-Debug $command

    $command | Invoke-Expression

    Write-Host ""
    Add-BorderAroundText "Zip Deploy Completed" 100
    Write-Host "To browse to webapp, browse to http://$SiteName.$stampName.antares-test.windows-int.net/"
    Write-Host "To review the logs, browse to http://$SiteName.scm.$stampName.antares-test.windows-int.net/deploymentlogs/"
    

}