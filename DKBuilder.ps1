Write-Output "DKBuilder.ps1"


if (! (Test-Path "DKPowershell")) { New-Item -Path 'DKPowershell' -ItemType Directory }
if (! (Test-Path "DKPowershell/functions")) { New-Item -Path 'DKPowershell/functions' -ItemType Directory }
if (! (Test-Path "DKPowershell/functions/DK.ps1")) {	Write-Warning "DK.ps1 does not exist" }

. "DKPowershell/functions/DK.ps1"


Write-Output "DKSCRIPT_PATH = $DKSCRIPT_PATH"

Read-Host -Prompt "Press Enter to exit" 