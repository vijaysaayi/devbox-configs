function New-StampConfig(){
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$StampName,
        
        [string]$GeoRegion = "West US"        
    ) 

    Add-BorderAroundText "Generating new Lockbox config for stamp : $StampName" 100
    $dash='"'
    $command = "$env:OUTPUTROOT/debug-amd64/Hosting/Azure/RDTools/Tools/Antares/AntaresDeployment.exe SetupPrivateStamp $StampName /SubscriptionId:$env:azSubscriptionId /DefaultLocation:${dash}${GeoRegion}${dash} /workerPoolsToCreate:lw"
    Write-Debug "Executing command : $command"
    $command | Invoke-Expression
    
}