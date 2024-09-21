if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_callDKCmake){ $dk_callDKCmake = 1 } else{ return }

##################################################################################
# dk_callDKCmake(func) args
#
#
function Global:dk_callDKCmake() {
	dk_debugFunc 2
	
	# TODO
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_debugFunc 0
	
	#dk_callDKCmake dk_messageBox rtn_var "MessageBox Title" "Testing dk_messageBox"
	#dk_debug "rtn_var = ${rtn_var}"
}
