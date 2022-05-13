function Update-AntaresCmdConfig {
    [CmdletBinding()]
    param (           
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$StampName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$GeoRegionName,

        [Switch]$HasGeoMaster
    ) 
    Add-BorderAroundText "Updating antarescmd.config.exe with stamp details : $WebSpaceName" 100
    
    $antarates_cmd = [Environment]::GetEnvironmentVariable("antarescmdpath", "User");  
    $file_name = "$antarates_cmd.config"  
    $region = $GeoRegionName.ToLower() -replace "\s"

    [xml]$xmlDoc = Get-Content $file_name
    $nodes = $xmlDoc.SelectNodes("configuration/appSettings").ChildNodes

    $nodes | ForEach-Object {
        if( $_.key -eq "CertFindValue") {
            $_.value = "8A7CA844B4AA0DC20270C9DEE5869E4962336533"
            display_message $_.key $_.value
        }

        if( $_.key -eq "ServiceURL") {
            if ($HasGeoMaster) {
                $_.value = "https://$StampName.cloudapp.net"
                display_message $_.key $_.value
            }
            else {
                $_.value = "https://$StampName.$region.cloudapp.azure.com:454"
                display_message $_.key $_.value
            }                        
        }
    }

    Write-Host ""    
    Write-Host "Saving changes"    
    $xmlDoc.Save($file_name)
}

function display_message([string] $key, [string] $value)
{
    Write-Host "Updated $key to $value"
}