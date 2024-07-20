if(!$DKINIT){ .${env:DKPOWERSHELL_FUNCTIONS_DIR}\DK.ps1 }
if(!$dk_pause){ $dk_pause = 1 } else{ return }

##################################################################################
# dk_pause()
#
#    Pause execution and wait for <enter> keypress to continue
#
function GLOBAL:dk_pause() {
	dk_debugFunc


	Read-Host -Prompt "Press Enter to continue"
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
	dk_debugFunc
	
	
	dk_pause
}