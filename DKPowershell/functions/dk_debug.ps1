if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_debug){ $dk_debug = 1 } else{ return }


if(!$ENABLE_dk_debug){ $global:ENABLE_dk_debug = 1   }
if(!$PAUSE_ON_DEBUG) { $global:PAUSE_ON_DEBUG = 0    }
if(!$TRACE_ON_DEBUG) { $global:TRACE_ON_DEBUG = 0    }
if(!$LINE_ON_DEBUG)  { $global:LINE_ON_DEBUG = 0     }
if(!$HALT_ON_DEBUG)  { $global:HALT_ON_DEBUG = 0     }
if(!$DEBUG_TAG)      { $global:DEBUG_TAG = "DEBUG: " }
################################################################################
# dk_debug(message)
#
#    Print a debug message to the console
#
#    @message	- The message to print
#
function Global:dk_debug($message) {
	dk_debugFunc 1

	if($ENABLE_dk_debug -ne 1){ return }

	if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
	dk_echo "${blue}${DEBUG_TAG}${message}${clr}"
	if($PAUSE_ON_DEBUG){ dk_echo "${blue}*** PAUSE_ON_DEBUG ***${clr}"; dk_pause }
	if($TRACE_ON_DEBUG){ dk_echo "${blue}*** TRACE_ON_DEBUG ***${clr}"; dk_stacktrace }
	if($LINE_ON_DEBUG) { dk_echo "${blue}*** LINE_ON_DEBUG ***${clr}";  dk_showFileLine $(__FILE__ 1) $(__LINE__ 1) }
	if($HALT_ON_DEBUG) { dk_echo "${blue}*** HALT_ON_DEBUG ***${clr}";  dk_exit }
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_debug "test dk_debug message"
}
