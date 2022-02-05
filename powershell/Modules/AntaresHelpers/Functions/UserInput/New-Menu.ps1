using namespace System.Management.Automation.Host

function New-Menu {
    [CmdletBinding()]
    param(
        [string]$Title="",

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Question,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Options,

        [int]$DefaultOption = 0
    )
    $opts = New-Object System.Collections.Generic.List[ChoiceDescription]
    foreach ($option in $Options) {        
        $o = [ChoiceDescription]::new( $option , "${Option}")
        $opts.Add($o)
    }
    
    $selectionIndex = $host.ui.PromptForChoice($Title, $Question, $opts, $DefaultOption)
    $selection = $options[$selectionIndex]    
    Write-Host ""
    return $selection, $selectionIndex
}
