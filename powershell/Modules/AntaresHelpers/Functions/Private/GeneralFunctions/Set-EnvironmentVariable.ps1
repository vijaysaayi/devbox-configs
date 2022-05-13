# function Set-EnvironmentVariable{
#     [CmdletBinding()]
#     Param
#     (
#         [Parameter(Mandatory=$true, Position=0)]
#         [string] $Name,
#         [Parameter(Mandatory=$true, Position=1)]
#         [string] $Value
#     )

#     [System.Environment]::SetEnvironmentVariable($Name,$Value)
# }
