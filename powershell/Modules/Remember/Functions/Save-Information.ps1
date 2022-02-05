function Save-Information(){
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Value
    ) 
        
    $informationFileName = "$env:UserProfile/remember-module.ps1"

    if(! (Test-Path "$informationFileName" -PathType Leaf)){
        $information = @{}        
    }
    else{
        $information = (Get-Content -raw $informationFileName)  -replace '\\','\\' | ConvertFrom-StringData
    }

    $information[$Name] = $Value

    $information | ConvertTo-StringData | Set-Content -Path $informationFileName
    Write-Host "Successfully remembering $Value as $Name"
}

New-Alias -Name remem -Value Save-Information
