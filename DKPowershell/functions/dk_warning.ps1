if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

################################################################################
# dk_warning(message)
#
#    Print a warning message to the console
#
#    @message	- The message to print
#
function Global:dk_warning($message){
	dk_debugFunc 1
	
	dk_call dk_log WARNING "${message}"
}














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_warning "test dk_warning message"
}
