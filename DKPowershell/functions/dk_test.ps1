if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_test){ $dk_test = 1 } else{ return }

##################################################################################
# dk_test()
#
#
function GLOBAL:dk_test() {
	dk_debugFunc 0 99

	dk_call dk_echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
	dk_call dk_echo "DKSCRIPT_DIR  = ${DKSCRIPT_DIR}"
	dk_call dk_echo "DKSCRIPT_NAME = ${DKSCRIPT_NAME}"
	dk_call dk_echo "DKSCRIPT_EXT  = ${DKSCRIPT_EXT}"
	dk_call dk_echo "__FILE__      = $(__FILE__)"
	dk_call dk_echo "__LINE__      = $(__LINE__)"
	dk_call dk_echo "__FUNCTION__  = $(__FUNCTION__)"
	dk_call dk_echo "__ARGC__      = $(__ARGC__)"
	dk_call dk_echo "__ARGV__      = $(__ARGV__)"
	dk_call dk_echo "__CALLER__    = $(__CALLER__)"
	#if($args[0]){ dk_call dk_echo "args[0]      = ${args[0]}" }
	
	$all_args = $PsBoundParameters.Values + ${args}
	if($all_args){ dk_call dk_debug "all_args = $all_args"   }
	if($args)    { dk_call dk_debug "args     = $args"       }
	if($args[0]) { dk_call dk_debug "args[0]  = $($args[0])" }
	if($args[1]) { dk_call dk_debug "args[1]  = $($args[1])" }
	if($args[2]) { dk_call dk_debug "args[2]  = $($args[2])" }
	if($args[3]) { dk_call dk_debug "args[3]  = $($args[3])" }
	if($args[4]) { dk_call dk_debug "args[4]  = $($args[4])" }
	if($args[5]) { dk_call dk_debug "args[5]  = $($args[5])" }
	
	return "return value from dk_test.ps1"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	$rtn_var = dk_call dk_test "arg 1" "arg 2"
	
	dk_call dk_echo
	dk_call dk_echo "##### DKTEST() ###############"
	dk_call dk_echo "rtn_var = ${rtn_var}"
}
