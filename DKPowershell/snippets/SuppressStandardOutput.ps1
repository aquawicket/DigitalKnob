# Suppress Standard Output
# https://www.robvanderwoude.com/powershellsnippets.php#SuppressStdOut
some-command | Out-Null # slow
some-command > $null # fast and easier to understand for shell afficionados
[void] some-command # fastest, but works only if output is object, not if written to screen with Write-Host
$dummy = some-command( ) # alternative; your IDE may complain about unused variable $dummy
