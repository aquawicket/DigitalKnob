if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#TODO #include guard

if(!(${PAUSE_ON_EXIT})) { $global:PAUSE_ON_EXIT = 0 }
##################################################################################
# dk_exit(exit_code)
#
#
function Global:dk_exit() { # $exit_code
	dk_debugFunc 0 1
	
	#$allArgs = $PsBoundParameters.Values + ${args}
	#exit $allArgs
	
	if(!($args[0])){ 
		$exit_code = 0 	## default exit code is 0
	} else {
		$exit_code = $args[0]
	}
	dk_call dk_echo "dk_exit $exit_code"
	if(${PAUSE_ON_EXIT} -eq 1){ dk_call dk_echo "*** PAUSE_ON_EXIT exit_code:${exit_code} ***"; dk_call dk_pause }
	exit $exit_code
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	#dk_call dk_exit
	#dk_call dk_exit 0
	dk_call dk_exit 123
}
