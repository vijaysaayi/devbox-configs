function Show-Information(){
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    ) 
        
    $information = Get-Information
    if($information.Count -gt 0){
        if( ! $information.ContainsKey($Name)){
            Write-Host "Could not recollect anything, please use rem command to remember something"        
            return
        }
        else{
            $informationValue = $information[$Name];
            Write-Host "$informationValue"
        }
    }
}

New-Alias -Name rec -Value Show-Information

