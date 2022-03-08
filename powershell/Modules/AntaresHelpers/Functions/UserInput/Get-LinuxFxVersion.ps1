using namespace System.Management.Automation.Host

function Get-LinuxFxVersion {
    [CmdletBinding()]
    param(
        
    )
    $availableStacks = @('&Python','.Net&Core','&Node','&Go', 'P&HP')
    Write-Host ""
    $selectedStack, $selectedStackIndex = New-Menu -Title "" -Question "Stack :" -Options $availableStacks
    $stack = ""
    switch ($selectedStack) {
        '&Python' {  
            $availableVersions = @('3.&10','3.&9','3.&8','3.&7','3.&6', '&2.7')

            $selectedVersion, $selectedVersionIndex = New-Menu -Title "" -Question "Python Version :" -Options $availableVersions -DefaultOption 1
            switch($selectedVersionIndex)
            {
                0 { $python_version="3.10"}
                1 { $python_version="3.9"}
                2 { $python_version="3.8"}
                3 { $python_version="3.7"}
                4 { $python_version="3.6"}
                5 { $python_version="2.7"}
            }
            
            $stack = "PYTHON|$python_version"
        }
        '.Net&Core' { 
            $availableVersions = @('&3.1','&5.0','&6.0', '&7.0')

            $selectedVersion, $selectedVersionIndex = New-Menu -Title "" -Question ".NetCore Version :" -Options $availableVersions -DefaultOption 0
            switch($selectedVersionIndex)
            {
                0 { $dotnetVersion="3.1"}
                1 { $dotnetVersion="5.0"}
                2 { $dotnetVersion="6.0"}
                3 { $dotnetVersion="7.0"}
            }
            
            $stack = "DOTNETCORE|$dotnetVersion"
        }
        '&Node' {  
            $availableVersions = @('1&2','1&4','1&6', '1&8')

            $selectedVersion, $selectedVersionIndex = New-Menu -Title "" -Question "Node Version :" -Options $availableVersions -DefaultOption 0
            switch($selectedVersionIndex)
            {
                0 { $nodeVersion="12-lts"}
                1 { $nodeVersion="14-lts"}
                2 { $nodeVersion="16-lts"}
                3 { $nodeVersion="18-lts"}
            }
            
            $stack = "NODE|$nodeVersion"            
        }
        '&Go' { 
            $availableVersions = @('1.1&6')
            
            $selectedVersion, $selectedVersionIndex = New-Menu -Title "" -Question "GO Version :" -Options $availableVersions -DefaultOption 0
            switch($selectedVersionIndex)
            {
                0 { $goVersion="1.16"}
            }
            
            $stack = "GO|$goVersion"     

         }
        'P&HP' {  }
        Default {}
    }
    return $stack
}
