if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_call){ $dk_call = 1 } else{ return }

##################################################################################
# dk_call(command, args)
#
#
function Global:dk_call(){
	dk_debugFunc 0 99

	#$allArgs = $PsBoundParameters.Values + ${args}
	#$rest = $args[1..($args.Length-1)]
	#$first, $rest = $PsBoundParameters.Values + ${args}
	$first, $rest = ${args}
	
	& $first $rest
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_info "test message using dk_call"
}