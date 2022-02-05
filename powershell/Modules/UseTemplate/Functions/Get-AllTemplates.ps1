function Get-AllTemplates(){
    [CmdletBinding()]
    param (
         
    ) 
        
    $bookmarkFileName = "$env:UserProfile/use-template-bookmarks.ps1"

    if(! (Test-Path "$bookmarkFileName" -PathType Leaf)){
        Write-Host "Could not find any template, please use Save-Template command before running this command"        
        return
    }
    (Get-Content -raw $bookmarkFileName)  -replace '\\','\\' | ConvertFrom-StringData    
}