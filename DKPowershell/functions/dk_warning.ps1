if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_warning){ $dk_warning = 1 } else{ return }

if(!$ENABLE_dk_warning){ $global:ENABLE_dk_warning = 1 }
if(!$TRACE_ON_WARNING) { $global:TRACE_ON_WARNING = 0  }
if(!$LINE_ON_WARNING)  { $global:LINE_ON_WARNING = 0   }
if(!$PAUSE_ON_WARNING) { $global:PAUSE_ON_WARNING = 0  }
if(!$HALT_ON_WARNING)  { $global:HALT_ON_WARNING = 0   }
#$WARNING_TAG="  WARNING: "
################################################################################
# dk_warning(message)
#
#    Print a warning message to the console
#
#    @message	- The message to print
#
function Global:dk_warning($message){
	dk_debugFunc 1

	#$allArgs = $PsBoundParameters.Values + ${args}
	
	if($ENABLE_dk_warning -ne 1){ return }

	dk_echo "${yellow}${WARNING_TAG}${message}${clr}"
	if($TRACE_ON_WARNING){ dk_echo "${yellow}*** TRACE_ON_WARNING ***${clr}"; dk_stacktrace }
	if($LINE_ON_WARNING) { dk_echo "${yellow}*** LINE_ON_WARNING ***${clr}";  dk_showFileLine $(__FILE__ 1) $(__LINE__ 1) }
	if($PAUSE_ON_WARNING){ dk_echo "${yellow}*** PAUSE_ON_WARNING ***${clr}"; dk_pause }
	if($HALT_ON_WARNING) { dk_echo "${yellow}*** HALT_ON_WARNING ***${clr}";  dk_exit }
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	
	dk_warning "test dk_warning message"
}
