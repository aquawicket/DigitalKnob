if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_debug){ $dk_debug = 1 } else{ return }


if(!$ENABLE_dk_debug){ $global:ENABLE_dk_debug = 1 }
if(!$TRACE_ON_DEBUG) { $global:TRACE_ON_DEBUG = 0  }
if(!$LINE_ON_DEBUG)  { $global:LINE_ON_DEBUG = 0   }
if(!$PAUSE_ON_DEBUG) { $global:PAUSE_ON_DEBUG = 0  }
if(!$HALT_ON_DEBUG)  { $global:HALT_ON_DEBUG = 0   }
#$DEBUG_TAG="  DEBUG: "
################################################################################
# dk_debug(message)
#
#    Print a debug message to the console
#
#    @message	- The message to print
#
function Global:dk_debug($allArgs) {
	dk_debugFunc
	$allArgs = $PsBoundParameters.Values + $args
	
	
	if($ENABLE_dk_debug -ne 1){ return }

	dk_echo "${blue}${DEBUG_TAG}${allArgs}${clr}"
	if($TRACE_ON_DEBUG){ dk_echo "${blue}*** TRACE_ON_DEBUG ***${clr}"; dk_stacktrace }
	if($LINE_ON_DEBUG) { dk_echo "${blue}*** LINE_ON_DEBUG ***${clr}";  dk_showFileLine $(__FILE__ 1) $(__LINE__ 1) }
	if($PAUSE_ON_DEBUG){ dk_echo "${blue}*** PAUSE_ON_DEBUG ***${clr}"; dk_pause }
	if($HALT_ON_DEBUG) { dk_echo "${blue}*** HALT_ON_DEBUG ***${clr}";  dk_exit }
}



function Global:DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### 
	dk_debugFunc
	
	
	dk_debug "test dk_debug message"
}
