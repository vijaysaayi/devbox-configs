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
    Write-Host ""
    Write-Host "Setting WSL to use stampname as $stampName"
    $command="remember stampname $stampName -q"
    "wsl -e zsh -li -c '$command'" | Invoke-Expression
    Write-Host ""
    Write-Host "Setting WSL to use instance as $stampName-lw0large_0"
    $get_instance_list_command = '$(generate-instances-list | grep "large" | grep 0)'
    $command="remember instance $get_instance_list_command -q"
    "wsl -e zsh -li -c '$command'" | Invoke-Expression

}