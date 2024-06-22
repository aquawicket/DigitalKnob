if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_verbose){ $dk_verbose = 1 } else{ return }

if(!$ENABLE_dk_verbose){ $global:ENABLE_dk_verbose = 1 }
if(!$TRACE_ON_VERBOSE) { $global:TRACE_ON_VERBOSE = 0  }
if(!$LINE_ON_VERBOSE)  { $global:LINE_ON_VERBOSE = 0   }
if(!$PAUSE_ON_VERBOSE) { $global:PAUSE_ON_VERBOSE = 0  }
if(!$HALT_ON_VERBOSE)  { $global:HALT_ON_VERBOSE = 0   }
#$VERBOSE_TAG="  VERBOSE: "
################################################################################
# dk_verbose(message)
#
#    Print a warning message to the console
#
#    @message	- The message to print
#
function Global:dk_verbose() {
	dk_debugFunc
	$allArgs = $PsBoundParameters.Values + $args
	
	
	if($ENABLE_dk_verbose -ne 1){ return }

	dk_echo "${cyan}${VERBOSE_TAG}${allArgs}${clr}"
	if($TRACE_ON_VERBOSE){ dk_echo "${cyan}*** TRACE_ON_VERBOSE ***${clr}"; dk_stacktrace }
	if($LINE_ON_VERBOSE) { dk_echo "${cyan}*** LINE_ON_VERBOSE ***${clr}";  dk_showFileLine $(__FILE__ 1) $(__LINE__ 1) }
	if($PAUSE_ON_VERBOSE){ dk_echo "${cyan}*** PAUSE_ON_VERBOSE ***${clr}"; dk_pause }
	if($HALT_ON_VERBOSE) { dk_echo "${cyan}*** HALT_ON_VERBOSE ***${clr}";  dk_exit }
}



function Global:DKTEST() { ###########################################################################################
	dk_debugFunc
	
	
	dk_verbose "test dk_verbose message"
}
