function pulldev{
    git.exe pull --progress -v --no-rebase "origin" dev
}

function hc
{   
    $url = "$args.westus.cloudapp.azure.com:454"
    Write-Host $url
    psping $url
}

function browse {
    $stamp_name = [Environment]::GetEnvironmentVariable("stampname", "User");
    $url = "http://$args.$stamp_name.antares-test.windows-int.net"
    Write-Host "Launch url $url"
    Start-Process -PSPath $url
}

function browse-scm {
    $stamp_name = [Environment]::GetEnvironmentVariable("stampname", "User");
    $url = "http://$args.scm.$stamp_name.antares-test.windows-int.net/newui"
    Write-Host "Launch url $url"
    Start-Process -PSPath $url
}

function wagit {
    git -c http.sslVerify=false $args
}

function curl {
    cmd /c curl --dump-header - $args
}

function build {
    .\build-corext.cmd
}

function antcmdconf {
    code C:\wagit\AAPT-Antares-WebSites\out\debug-amd64\hosting\Azure\RDTools\Tools\Antares\AntaresCmd.exe.config
    Write-Host '<add key="CertFindValue" value="3F028F0011270295550E2A6BA7748D419235CA70" />'
    Write-Host '<add key="ServiceURL" value="https://visaayirlnx002.westus.cloudapp.azure.com:454" />'
    Write-Host '<add key="ServiceURL" value="https://visaayirlnx002.cloudapp.net" />'
}

function downloads {
    Set-Location -Path "C:\Users\visaayir\Downloads"
}

function documents {
    Set-Location -Path "C:\Users\visaayir\Documents"
}

function desktop {
    Set-Location -Path "C:\Users\visaayir\Desktop"
}

function websites {
    Set-Location -Path "D:\websites"
}

function stacks {
    Set-Location -Path "D:\stacks"
}

function delete_empty_rsg {
    $resources = az group list -o tsv --query [].name
    foreach($i in $resources) {
        $rs = $(az resource list -g $i -o tsv)
        if (! $rs) 
        {   az group delete -n $i -y --no-wait
            Write-Host "Deleting $i ..."
        }
    }
}

function deploy_stamp {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $StampName         
    )
    Set-Location -Path "C:\wagit\AAPT-Antares-WebSites\src\Hosting"
    .\devdeploy.cmd $StampName Antares_StompVmss.xml 
}

function c {
    cmd /c $args
}

function add_pvtstamp_remote {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $siteName         
    )
    $stampname = [Environment]::GetEnvironmentVariable("stampname", "User");
    $url = "visaayir"
    $password = $stampname
    $remoteUrl = "https://${user}:${password}@$siteName.scm.$stampname.antares-test.windows-int.net/$siteName.git"
    Invoke-Expression -Command "git remote add azure $remoteUrl"    
}

function clone {
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $repositoryUrl
    )
    $currentDir = Get-Location 
    $tempPath = Join-Path -Path $currentDir -ChildPath "temp"    
    $folder     = (Get-Item $currentDir)
    $siteName = $folder.Name   
    git clone $repositoryUrl temp  
    cd temp  
    Move-Item -Path "*.*" -Destination $currentDir -Exclude ".git\*"
    add_pvtstamp_remote -siteName $siteName  
    cd ..
    Remove-Item $tempPath -Force -Recurse -ErrorAction SilentlyContinue
}

function search(){
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $filter,
        [string] $directory = ""
    )

    if ($directory -eq "")
    {
        $directory = Get-Location 
    }

    Get-ChildItem -path $directory  -file -ea silent -recurse -filter $filter
}

function get-tags(){
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $repository
    )
    $url =  "https://mcr.microsoft.com/v2/$repository/tags/list"
    Write-Host "Launch url $url"
    Start-Process -PSPath $url
}

function use-stamp(){
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $stampName
    )

    [Environment]::SetEnvironmentVariable("stampname", $stampName, "User")
}

function use-subscription(){
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $subscriptionId
    )

    [Environment]::SetEnvironmentVariable("azSubscriptionId", $subscriptionId, "User")
}

function get-acr-token(){
    Param
    (
        [string] $acrName = "visaayirexpacr"
    )
    $subscriptionId = [Environment]::GetEnvironmentVariable("azSubscriptionId", "User");
    az acr login -n $acrName --subscription $subscriptionId --expose-token
}
Remove-Item alias:curl
Set-Alias wcurl Invoke-WebRequest

#################################################
# Update the following Paths
#################################################
Import-Module "C:\wagit\Scripts\PSModules\AntaresHelpers\AntaresHelpers.psm1" -Force
Import-Module "C:\wagit\Scripts\PSModules\UseTemplate\use-template-module.psm1" -Force
Import-Module "C:\wagit\Scripts\PSModules\Remember\remember-module.psm1" -Force

[System.Environment]::SetEnvironmentVariable('OUTPUTROOT','C:\wagit\AAPT-Antares-WebSites\out')
