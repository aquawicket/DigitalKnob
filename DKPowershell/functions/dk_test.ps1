if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_test){ $dk_test = 1 } else{ return }

##################################################################################
# dk_test()
#
#
function GLOBAL:dk_test($str, $num) {
	dk_debugFunc 2

	dk_call dk_info "test from dk_info"
	dk_call dk_debug "test from dk_debug"
	
	dk_call dk_echo "__FILE__     = $(__FILE__)"
	dk_call dk_echo "__LINE__     = $(__LINE__)"
	dk_call dk_echo "__FUNCTION__ = $(__FUNCTION__)"
	dk_call dk_echo "__ARGC__     = $(__ARGC__)"
	dk_call dk_echo "__ARGV__     = $(__ARGV__)"
	dk_call dk_echo "__CALLER__   = $(__CALLER__)"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_test string1 123
}
