Write-Output "DKBuilder.ps1"

###### DK_INIT ######
if (! (Test-Path "DKPowershell")) { New-Item -Path 'DKPowershell' -ItemType Directory }
if (! (Test-Path "DKPowershell/functions")) { New-Item -Path 'DKPowershell/functions' -ItemType Directory }
if (! (Test-Path "DKPowershell/functions/DK.ps1")) {	Write-Warning "DK.ps1 does not exist" }

echo "PWD = $PWD"
Import-Module -Global $PWD\DKPowershell\functions\DK.ps1


###### Global variables ######
Write-Output "DKSCRIPT_PATH = $DKSCRIPT_PATH"
Write-Output "DKSCRIPT_DIR = $DKSCRIPT_DIR"
Write-Output "DKSCRIPT_NAME = $DKSCRIPT_NAME"
Write-Output "DKPOWERSHELL_DIR = $DKPOWERSHELL_DIR"

###### Load Main Program ######
dk_load dk_buildMain
dk_load dk_getDKPaths
dk_load dk_debugFunc
dk_load dk_makeDirectory
Import-Module -Global $DKPOWERSHELL_DIR\functions\dk_buildMain.ps1
dk_buildMain
Read-Host -Prompt "Press Enter to exit" 