function Get-Information(){
    [CmdletBinding()]
    param (
         
    ) 
        
    $informationFileName = "$env:UserProfile/remember-module.ps1"

    if(! (Test-Path "$informationFileName" -PathType Leaf)){
        Write-Host "Could not recollect anything, please use rem command to remember something"        
        return
    }
    (Get-Content -raw $informationFileName)  -replace '\\','\\' | ConvertFrom-StringData    
}

New-Alias -Name rec-all -Value Get-Information
