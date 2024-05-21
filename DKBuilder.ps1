Write-Output "DKBuilder.ps1"

###### DK_INIT ######
if (! (Test-Path "DKPowershell")) { New-Item -Path 'DKPowershell' -ItemType Directory }
if (! (Test-Path "DKPowershell/functions")) { New-Item -Path 'DKPowershell/functions' -ItemType Directory }
if (! (Test-Path "DKPowershell/functions/DK.ps1")) { Invoke-WebRequest -URI "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBatch/functions/DK.ps1" -OutFile "DKPowershell\functions\DK.cmd" }

. $PWD\DKPowershell\functions\DK.ps1


###### Global variables ######
Write-Output "DKSCRIPT_PATH = $DKSCRIPT_PATH"
Write-Output "DKSCRIPT_DIR = $DKSCRIPT_DIR"
Write-Output "DKSCRIPT_NAME = $DKSCRIPT_NAME"
Write-Output "DKPOWERSHELL_DIR = $DKPOWERSHELL_DIR"


###### Load Main Program ######
dk_buildMain
Read-Host -Prompt "Press Enter to exit" 