if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_debug){ $dk_debug = 1 } else{ return }

#dk_set ENABLE_dk_debug = 0
#dk_set TRACE_ON_DEBUG = 1
#dk_set LINE_ON_DEBUG = 1
#dk_set PAUSE_ON_DEBUG = 1
#dk_set HALT_ON_DEBUG = 1
#dk_set DEBUG_TAG " DEBUG: "
################################################################################
# dk_debug(message)
#
#    Print a debug message to the console
#
#    @message	- The message to print
#
function Global:dk_debug($message) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	#$allArgs = $PsBoundParameters.Values + $args
	
	if(!$ENABLE_dk_debug){ $global:ENABLE_dk_debug = 1 }
	if($ENABLE_dk_debug -ne 1){ return }

	if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
	dk_echo "${blue}${DEBUG_TAG}${message}${clr}"
	if($TRACE_ON_DEBUG){ dk_echo "${blue}*** TRACE_ON_DEBUG ***${clr}"; dk_stacktrace }
	if($LINE_ON_DEBUG) { dk_echo "${blue}*** LINE_ON_DEBUG ***${clr}";  dk_showFileLine $(__FILE__ 1) $(__LINE__ 1) }
	if($PAUSE_ON_DEBUG){ dk_echo "${blue}*** PAUSE_ON_DEBUG ***${clr}"; dk_pause }
	if($HALT_ON_DEBUG) { dk_echo "${blue}*** HALT_ON_DEBUG ***${clr}";  dk_exit }
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### 
	dk_debugFunc
	
	
	dk_debug "test dk_debug message"
	
	#intentional fail: incorrect number of arguments
	#dk_debug ""
}
