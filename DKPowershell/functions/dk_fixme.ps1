if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_fixme){ $dk_fixme = 1 } else{ return } #include guard

##################################################################################
# dk_fixme(message)
#
#	Print a fixme message to the console
#
#	@msg	- The message to print
#
function Global:dk_fixme($message){
	dk_debugFunc 1
	
	dk_call dk_log FIXME "${message}"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_fixme "test dk_fixme message"
}
