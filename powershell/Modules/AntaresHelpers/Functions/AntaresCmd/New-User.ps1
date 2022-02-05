function New-User {
    [CmdletBinding()]
    param (           
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$UserName,
        
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$PassKey
    ) 
    
    $antarates_cmd = [Environment]::GetEnvironmentVariable("antarescmdpath", "User");
    Write-Host ""
    Write-Host "---------------------------------------------------------------------------"
    Write-Host "Creating general user : $UserName"
    Write-Host "---------------------------------------------------------------------------"
    "$antarates_cmd CreateUser $UserName /publishingUserName:$UserName /publishingPassword:$PassKey /UseCsm:false" | Invoke-Expression
    Write-Host "Created new user $UserName with password $StampName"
}