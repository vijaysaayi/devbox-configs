function New-StampConfigDirectory {
    [CmdletBinding()]
    param (           
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$LocalStampConfigPath
    ) 
    
    Write-Host ""
    Add-BorderAroundText "Checking if Stamp config folder exists and creating if needed" 100
    [System.IO.Directory]::CreateDirectory($LocalStampConfigPath+'/STAMPCONFIG')

}