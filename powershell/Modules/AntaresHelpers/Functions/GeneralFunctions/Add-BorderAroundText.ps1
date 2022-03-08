function Add-BorderAroundText {
    [CmdletBinding()]
    param (           
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Message,

        [int]$BoxLength = 60
    ) 
    Write-Debug $BoxLength
    Write-Debug $Message.Length
    if($BoxLength -le $Message.Length)
    {
        $BoxLength = $Message.Length +6 
    }
    Write-Debug $BoxLength
   
    Add-HorizontalLine $BoxLength
    Add-Message $Message $BoxLength
    Add-HorizontalLine $BoxLength
}

function Add-HorizontalLine($length)
{
    $horizontal_length = $length - 2
    $horizontal = "-" * $horizontal_length
    Write-Host "+$horizontal+"
}

function Add-Message($message, $boxLength=50){
    
    if ( $message.Length % 2 -eq 1)
    {
        $message = "$message "
    }
    $whitespaces_length = $boxLength - $message.Length -5
    $whitespaces_length_half =[math]::floor($whitespaces_length/2)
    $whitespaces = ""
    if( $whitespaces_length -gt 0 ){
        $whitespaces = " " *  $whitespaces_length_half
    }
    
    Write-Host "| $whitespaces $message $whitespaces |"
}
