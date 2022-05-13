function Initialize-DevboxForLinuxBvt(){
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$StampName,
        
        [string]$GeoRegion = "West US"        
    )        
}