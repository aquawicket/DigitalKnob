if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_todo){ $dk_todo = 1 } else{ return }

##################################################################################
# dk_todo(message)
#
#	Print a todo message to the console
#
#	@msg	- The message to print
#
function Global:dk_todo() {
	dk_debugFunc 0 1
	dk_log TODO "${message}"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_todo "test dk_todo message"
}
