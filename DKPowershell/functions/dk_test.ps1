if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_test){ $dk_test = 1 } else{ return }

##################################################################################
# dk_test()
#
#
function GLOBAL:dk_test() {
	dk_debugFunc 0

	dk_call dk_echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
	dk_call dk_echo "DKSCRIPT_DIR  = ${DKSCRIPT_DIR}"
	dk_call dk_echo "__FILE__      = $(__FILE__)"
	dk_call dk_echo "__LINE__      = $(__LINE__)"
	dk_call dk_echo "__FUNCTION__  = $(__FUNCTION__)"
	dk_call dk_echo "__ARGC__      = $(__ARGC__)"
	dk_call dk_echo "__ARGV__      = $(__ARGV__)"
	dk_call dk_echo "__CALLER__    = $(__CALLER__)"
	if($args[0]){ $arg0 = $args[0]; dk_call dk_echo "args[0]      = $arg0" }
	if($args[1]){ $arg1 = $args[1]; dk_call dk_echo "args[1]      = $arg1" }
	if($args[2]){ $arg2 = $args[2]; dk_call dk_echo "args[2]      = $arg2" }
	if($args[3]){ $arg3 = $args[3]; dk_call dk_echo "args[3]      = $arg3" }
	if($args[4]){ $arg4 = $args[4]; dk_call dk_echo "args[4]      = $arg4" }
	
	
	return "rtr_value"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_test
}
