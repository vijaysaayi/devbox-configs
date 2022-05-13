function Open-SshConnectionToStamp(){
    [CmdletBinding()]
    param (  
        [string]$StampName=""
    ) 
        
    $stampName = [Environment]::GetEnvironmentVariable("stampname", "User");
    $azureRdp = [Environment]::GetEnvironmentVariable("AzureRdpPath", "User");

    if ( $StampName -notmatch ""){
        $stampName = $StampName
    }

    "$azureRdp ssh $stampName" | Invoke-Expression
}