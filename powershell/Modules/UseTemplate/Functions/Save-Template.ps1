function Save-Template(){
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$TemplateName
    ) 
        
    $bookmarkFileName = "$env:UserProfile/use-template-bookmarks.ps1"

    if(! (Test-Path "$bookmarkFileName" -PathType Leaf)){
        $bookmarks = @{}        
    }
    else{
        $bookmarks = (Get-Content -raw $bookmarkFileName)  -replace '\\','\\' | ConvertFrom-StringData
    }

    $currentDir = Get-Location
    $bookmarks[$TemplateName] = ${currentDir}.Path

    $bookmarks | ConvertTo-StringData | Set-Content -Path $bookmarkFileName
    Write-Host "Successfully saved the path '$currentDir' by name $TemplateName"
}