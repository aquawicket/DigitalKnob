if(!$DKINIT){ .${env:DKPOWERSHELL_FUNCTIONS_DIR}\DK.ps1 }
if(!$dk_error){ $dk_error = 1 } else{ return }

if(!$ENABLE_dk_error){ $global:ENABLE_dk_error = 1 }
if(!$TRACE_ON_ERROR) { $global:TRACE_ON_ERROR = 1  }
if(!$LINE_ON_ERROR)  { $global:LINE_ON_ERROR = 1   }
if(!$PAUSE_ON_ERROR) { $global:PAUSE_ON_ERROR = 1  }
if(!$HALT_ON_ERROR)  { $global:HALT_ON_ERROR = 1   }
#$ERROR_TAG="  ERROR: "
################################################################################
# dk_error(message)
#
#    Print a error message to the console
#
#    @message	- The message to print
#
function Global:dk_error($message) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	#$allArgs = $PsBoundParameters.Values + $args
	
	
	if($ENABLE_dk_error -ne 1){ return }
	
	if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
	dk_echo "${red}${ERROR_TAG}${message}${clr}"
	if($TRACE_ON_ERROR){ dk_echo "${red}*** TRACE_ON_ERROR ***${clr}"; dk_stacktrace }
	if($LINE_ON_ERROR) { dk_echo "${red}*** LINE_ON_ERROR ***${clr}";  dk_showFileLine $(__FILE__ 1) $(__LINE__ 1) }
	if($PAUSE_ON_ERROR){ dk_echo "${red}*** PAUSE_ON_ERROR ***${clr}"; dk_pause }
	if($HALT_ON_ERROR) { dk_echo "${red}*** HALT_ON_ERROR ***${clr}";  dk_exit }
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
	dk_debugFunc
	
	
	dk_error "test dk_error message"
}