if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_error){ $dk_error = 1 } else{ return }

################################################################################
# dk_error(message)
#
#    Print a error message to the console
#
#    @message	- The message to print
#
function Global:dk_error($message) {
	dk_debugFunc 1
	dk_log ERROR "${message}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
function Global:DKTEST() { 
	dk_debugFunc 0	
	
	dk_error "test dk_error message"
}
