function Remove-Template(){
    [CmdletBinding()]
    param ( 
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$TemplateName
    ) 
        
    $bookmarkFileName = "$env:UserProfile/use-template-bookmarks.ps1"

    if(! (Test-Path "$bookmarkFileName" -PathType Leaf)){
        Write-Host "Could not find any bookmarks, please use Save-Template command"        
        return
    }
    $bookmarks = (Get-Content -raw $bookmarkFileName)  -replace '\\','\\' | ConvertFrom-StringData    
    $bookmarks.Remove($TemplateName)
    $bookmarks | ConvertTo-StringData | Set-Content -Path $bookmarkFileName

    Write-Host "Successfully removed the template reference $TemplateName"
}