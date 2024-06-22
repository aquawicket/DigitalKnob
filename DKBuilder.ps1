$global:ENABLE_dk_debugFunc = 0


###### DK_INIT ######
$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR = "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKPowershell/functions"
if(!(Test-Path "DKPowershell")){ New-Item -Path 'DKPowershell' -ItemType Directory }
if(!(Test-Path "DKPowershell/functions")){ New-Item -Path 'DKPowershell/functions' -ItemType Directory }
if(!(Test-Path "DKPowershell/functions/DK.ps1")){ Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1" -OutFile "DKPowershell/functions/DK.ps1" }

. $PWD/DKPowershell/functions/DK.ps1


###### Global variables ######
Write-Output "DKSCRIPT_PATH = $DKSCRIPT_PATH"
Write-Output "DKSCRIPT_DIR = $DKSCRIPT_DIR"
Write-Output "DKSCRIPT_NAME = $DKSCRIPT_NAME"
Write-Output "DKPOWERSHELL_DIR = $DKPOWERSHELL_DIR"


###### Load Main Program ######
dk_load dk_buildMain
dk_buildMain
Read-Host -Prompt "Press Enter to exit" 