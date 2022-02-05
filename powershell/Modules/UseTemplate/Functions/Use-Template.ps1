function Use-Template(){
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$TemplateName
    ) 
        
    $bookmarks = Get-AllTemplates
    if($bookmarks.Count -gt 0){
        if( ! $bookmarks.ContainsKey($TemplateName)){
            Write-Host "Could not find any template, please use Save-Template command before running this command"        
            return
        }
        else{
            $currentDir = Get-Location            
            $templatesFolder = [Environment]::GetEnvironmentVariable("localTemplatesFolder", "User");

            if(!$templatesFolder ){
                Write-Host "The environment variable localTemplatesFolder is not set."                
                $templatesFolder = Read-Host -Prompt "Enter the templates folder directory : "
                [Environment]::SetEnvironmentVariable("localTemplatesFolder",$templatesFolder, "User")
                Write-Host "Successfully saved the templates directory as environment variable for the user"
            }

            Write-Host "Looking for templates in directory : $templatesFolder"
            $source = [System.IO.Path]::Combine($bookmarks[$TemplateName], "*")            
            Write-Host "Copying from $source"
            Copy-Item -Path $source -Destination $currentDir -Recurse -Exclude (".git") -Force
        }
    }
}
