if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

################################################################################
# dk_info(message)
#
#    Print a info message to the console
#
#    @message	- The message to print
#
function Global:dk_info($message) {
	dk_debugFunc 1
	
	dk_call dk_log INFO "$message"
}











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_info "test message from dk_info"
}

