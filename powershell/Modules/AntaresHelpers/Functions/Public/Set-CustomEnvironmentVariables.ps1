# function Set-CustomEnvironmentVariables()
# {
#     [CmdletBinding()]
#     param (
        
#     )
#     $wawshome = Get-EnvironmentVariable -Name "WAWSHOME"
#     Write-Debug "$wawshome"
#     if( ! $wawshome ){
#         $wawshome = 'C:/wagit/AAPT-Antares-WebSites'        
#         Write-Debug $wawshome
#         Set-EnvironmentVariable -Name 'WAWSHOME' -Value $wawshome
#     }

#     Set-EnvironmentVariable -Name 'OUTPUTROOT' -Value "$wawshome/out"
#     Set-EnvironmentVariable -Name 'SRCROOT' -Value "$wawshome/src"

# }

