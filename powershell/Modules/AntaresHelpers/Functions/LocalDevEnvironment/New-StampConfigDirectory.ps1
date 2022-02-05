function New-StampConfigDirectory {
    [CmdletBinding()]
    param (           
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$LocalStampConfigPath
    ) 
    
    Write-Host ""
    Write-Host "---------------------------------------------------------------------------"
    Write-Host "Checking if Stamp config folder exists and creating if needed"
    Write-Host "---------------------------------------------------------------------------"    
    [System.IO.Directory]::CreateDirectory($LocalStampConfigPath+'/STAMPCONFIG')

}