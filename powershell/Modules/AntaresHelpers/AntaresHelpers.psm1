Get-ChildItem -Path $PSScriptRoot\Functions -Recurse |
 ForEach-Object -Process {
     if($PSItem.FullName.Contains("ps1")){
        . $PSItem.FullName
     }     
 }