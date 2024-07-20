if(!$DKINIT){ .${env:DKPOWERSHELL_FUNCTIONS_DIR}\DK.ps1 }
if(!$dk_call){ $dk_call = 1 } else{ return }

##################################################################################
# dk_call(command, args)
#
#
function Global:dk_call(){
	dk_debugFunc
	#if($(__ARGC__) -lt 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	#$allArgs = $PsBoundParameters.Values + $args
	#$rest = $args[1..($args.Length-1)]
	#$first, $rest = $PsBoundParameters.Values + $args
	$first, $rest = $args
	
	& $first $rest
}


function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	dk_call dk_info "test message using dk_call"
}