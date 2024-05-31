if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_call){ $dk_call = 1 } else{ return }

dk_load dk_info
##################################################################################
# dk_call(<command args>)
#
#
function Global:dk_call(){
	#$MyInvocation | Format-List -Property *
	dk_debugFunc
	#if($(__ARGC__) -lt 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	#& $command $($MyInvocation.UnboundArguments)
	#$allArgs = $PsBoundParameters.Values + $args
	#echo "allArgs = $allArgs"

	$first, $rest = $PsBoundParameters.Values + $args
	#$_args_ = $allArgs[1..($allArgs.Length-1)]
	
	& $first @rest
}


function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_call dk_info "test message using dk_call"

}