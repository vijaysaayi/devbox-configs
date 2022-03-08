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
    Add-BorderAroundText "Creating general user : $UserName" 100
    "$antarates_cmd CreateUser $UserName /publishingUserName:$UserName /publishingPassword:$PassKey /UseCsm:false" | Invoke-Expression
    Write-Host "Created new user $UserName with password $StampName"
}