function Get-WslStampConfig {
    [CmdletBinding()]
    param (           
        
    ) 
    $stampName = [Environment]::GetEnvironmentVariable("stampname", "User");
    $azureRDPPath = [Environment]::GetEnvironmentVariable("AzureRdpPath", "User");
    $stampConfigPath = [Environment]::GetEnvironmentVariable("AntaresStampConfigPath", "User");
    
    Add-BorderAroundText "Setting up SSH on WSL for the stamp $stampName" 100
    Write-Debug "$azureRDPPath wslssh $stampName $stampConfigPath"
    "$azureRDPPath wslssh $stampName $stampConfigPath" | Invoke-Expression
    Write-Host ""
    Write-Host "Providing a+x permission for script_$stampName.sh"
    Write-Debug "$stampConfigPath_wsl = wsl -e wslpath $stampConfigPath"
    $stampConfigPath_wsl = wsl -e wslpath $stampConfigPath
    Write-Debug "wsl -e chmod a+x $stampConfigPath_wsl/script_$stampName.sh; dos2unix $stampConfigPath_wsl/script_$stampName.sh; $stampConfigPath_wsl/script_$stampName.sh"
    "wsl chmod a+x $stampConfigPath_wsl/script_$stampName.sh" | Invoke-Expression
    "wsl dos2unix $stampConfigPath_wsl/script_$stampName.sh" | Invoke-Expression
    "wsl $stampConfigPath_wsl/script_$stampName.sh" | Invoke-Expression
}