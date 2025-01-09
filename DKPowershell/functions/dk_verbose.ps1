if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#TODO #include guard

################################################################################
# dk_verbose(message)
#
#    Print a warning message to the console
#
#    @message	- The message to print
#
function Global:dk_verbose($message){
	dk_debugFunc 1
	
	dk_call dk_log VERBOSE "${message}"
}












###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_verbose "test dk_verbose message"
}
