if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_info){ $dk_info = 1 } else{ return }

dk_load dk_echo
dk_load dk_stacktrace
dk_load dk_showFileLine
dk_load dk_pause
dk_load dk_exit
if(!$ENABLE_dk_info){ $global:ENABLE_dk_info = 1 }
if(!$TRACE_ON_INFO) { $global:TRACE_ON_INFO = 0  }
if(!$LINE_ON_INFO)  { $global:LINE_ON_INFO = 0   }
if(!$PAUSE_ON_INFO) { $global:PAUSE_ON_INFO = 0  }
if(!$HALT_ON_INFO)  { $global:HALT_ON_INFO = 0   }
#$global:INFO_TAG = "  INFO: "
################################################################################
# dk_info(message)
#
#    Print a info message to the console
#
#    @message	- The message to print
#
function Global:dk_info($allArgs) {
	dk_debugFunc
	$allArgs = $PsBoundParameters.Values + $args
	
	
	if($ENABLE_dk_info -ne 1){ return }
		
	dk_echo "${white}${INFO_TAG}${allArgs}${clr}"
	if ($TRACE_ON_INFO){ dk_echo "${white}*** TRACE_ON_INFO ***${clr}"; dk_stacktrace }
	if ($LINE_ON_INFO) { dk_echo "${white}*** LINE_ON_INFO ***${clr}";  dk_showFileLine $(__FILE__ 1) $(__LINE__ 1) }
	if ($PAUSE_ON_INFO){ dk_echo "${white}*** PAUSE_ON_INFO ***${clr}"; dk_pause }
	if ($HALT_ON_INFO) { dk_echo "${white}*** HALT_ON_INFO ***${clr}";  dk_exit }
}



function Global:DKTEST() { ###########################################################################################
	dk_debugFunc
	
	
	dk_info "test message from dk_info"
}

