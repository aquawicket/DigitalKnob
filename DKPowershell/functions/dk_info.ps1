if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_info){ $dk_info = 1 } else{ return }

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
function Global:dk_info($message) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	#$allArgs = $PsBoundParameters.Values + $args
	
	
	if($ENABLE_dk_info -ne 1){ return }
		
	if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
	dk_echo "${white}${INFO_TAG}${message}${clr}"
	if ($TRACE_ON_INFO){ dk_echo "${white}*** TRACE_ON_INFO ***${clr}"; dk_stacktrace }
	if ($LINE_ON_INFO) { dk_echo "${white}*** LINE_ON_INFO ***${clr}";  dk_showFileLine $(__FILE__ 1) $(__LINE__ 1) }
	if ($PAUSE_ON_INFO){ dk_echo "${white}*** PAUSE_ON_INFO ***${clr}"; dk_pause }
	if ($HALT_ON_INFO) { dk_echo "${white}*** HALT_ON_INFO ***${clr}";  dk_exit }
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### 
	dk_debugFunc
	
	
	dk_info "test message from dk_info"
}

