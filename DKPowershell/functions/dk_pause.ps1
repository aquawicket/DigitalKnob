if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_pause){ $dk_pause = 1 } else{ return }

##################################################################################
# dk_pause()
#
#    Pause execution and wait for <enter> keypress to continue
#
function GLOBAL:dk_pause() {
	dk_debugFunc 0

	Read-Host -Prompt "Press Enter to continue"
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_pause
}
