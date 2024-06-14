if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_error){ $dk_error = 1 } else{ return }

dk_load dk_echo
dk_load dk_stacktrace
#dk_load dk_showFileLine
dk_load dk_pause
dk_load dk_exit
if(!$ENABLE_dk_error){ $global:ENABLE_dk_error = 1 }
if(!$TRACE_ON_ERROR) { $global:TRACE_ON_ERROR = 0  }
if(!$LINE_ON_ERROR)  { $global:LINE_ON_ERROR = 0   }
if(!$PAUSE_ON_ERROR) { $global:PAUSE_ON_ERROR = 1  }
if(!$HALT_ON_ERROR)  { $global:HALT_ON_ERROR = 0   }
#$ERROR_TAG="  ERROR: "
################################################################################
# dk_error(<message>)
#
#    Print a error message to the console
#
#    @message	- The message to print
#
function Global:dk_error($allArgs) {
	dk_debugFunc
	$allArgs = $PsBoundParameters.Values + $args
	
	
	if($ENABLE_dk_error -ne 1){ return }
	
	dk_echo "${red}${ERROR_TAG}${allArgs}${clr}"
	if($TRACE_ON_ERROR){ dk_echo "${red}*** TRACE_ON_ERROR ***${clr}"; dk_stacktrace }
	if($LINE_ON_ERROR) { dk_echo "${red}*** LINE_ON_ERROR ***${clr}";  dk_showFileLine $callerpath $message }
	if($PAUSE_ON_ERROR){ dk_echo "${red}*** PAUSE_ON_ERROR ***${clr}"; dk_pause }
	if($HALT_ON_ERROR) { dk_echo "${red}*** HALT_ON_ERROR ***${clr}";  dk_exit }
}




function Global:DKTEST() { ###########################################################################################
	dk_debugFunc
	
	
	dk_error "test dk_error message"
}