function Remove-Information(){
    [CmdletBinding()]
    param ( 
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    ) 
        
    $informationFileName = "$env:UserProfile/remember-module.ps1"

    if(! (Test-Path "$informationFileName" -PathType Leaf)){
        Write-Host "Could not recollect anything, please use rem command to remember something"        
        return
    }
    $information = (Get-Content -raw $informationFileName)  -replace '\\','\\' | ConvertFrom-StringData    
    $information.Remove($Name)
    $information | ConvertTo-StringData | Set-Content -Path $informationFileName

    Write-Host "Successfully forgotten $Name"
}

New-Alias -Name forget -Value Remove-Information