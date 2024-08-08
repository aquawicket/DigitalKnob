if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_clearScreen){ $dk_clearScreen = 1 } else{ return }

##################################################################################
# dk_clearScreen()
#
#
function Global:dk_clearScreen() {
	dk_debugFunc 0

	
	
	clear
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	
	dk_clearScreen
}