Write-Output "DKBuilder.ps1"

###### DK_INIT ######
if (! (Test-Path "DKPowershell")) { New-Item -Path 'DKPowershell' -ItemType Directory }
if (! (Test-Path "DKPowershell/functions")) { New-Item -Path 'DKPowershell/functions' -ItemType Directory }
if (! (Test-Path "DKPowershell/functions/DK.ps1")) {	Write-Warning "DK.ps1 does not exist" }
. "DKPowershell/functions/DK.ps1"


###### Global variables ######
#dk_printVar DKSCRIPT_PATH
#dk_printVar DKBATCH_DIR


::###### Load Main Program ######
Import-Module ./dk_buildMain.ps1
dk_buildMain
Read-Host -Prompt "Press Enter to exit" 