
###### DKBuilder ######

#$ENABLE_dk_debugFunc = 1

###### DKINIT ######
$DKSCRIPT_PATH = $Script:MyInvocation.MyCommand.Path
Copy-Item "$DKSCRIPT_PATH" -Destination "$env:TMP"
$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR = "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKPowershell/functions"
$DKPOWERHELL_DIR = "$PWD/DKPowershell"
$DKPOWERHELL_FUNCTIONS_DIR = "${DKPOWERHELL_DIR}/functions"
if(!(Test-Path $DKPOWERHELL_DIR)){ New-Item -Path $DKPOWERHELL_DIR -ItemType Directory }
if(!(Test-Path $DKPOWERHELL_FUNCTIONS_DIR)){ New-Item -Path $DKPOWERHELL_FUNCTIONS_DIR -ItemType Directory }
if(!(Test-Path $DKPOWERHELL_FUNCTIONS_DIR/DK.ps1)){ 
	Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1" -OutFile $DKPOWERHELL_FUNCTIONS_DIR/DK.ps1 
}
. $DKPOWERHELL_FUNCTIONS_DIR/DK.ps1
if($DKLOADED){exit} else{ $global:DKLOADED=1 }	# ignore the fork process that will return from DK.ps1 above






###### Load Main Program ######
dk_call dk_buildMain
Read-Host -Prompt "Press Enter to exit"
