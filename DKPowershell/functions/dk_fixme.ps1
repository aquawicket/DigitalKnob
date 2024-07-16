if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_fixme){ $dk_fixme = 1 } else{ return }

if(!$ENABLE_dk_fixme){ $global:ENABLE_dk_fixme = 1 }
if(!$TRACE_ON_FIXME) { $global:TRACE_ON_FIXME = 0  }
if(!$LINE_ON_FIXME)  { $global:LINE_ON_FIXME = 0   }
if(!$PAUSE_ON_FIXME) { $global:PAUSE_ON_FIXME = 0  }
if(!$HALT_ON_FIXME)  { $global:HALT_ON_FIXME = 0   }
$FIXME_TAG="  FIXME: "
##################################################################################
# dk_fixme(message)
#
#	Print a fixme message to the console
#
#	@msg	- The message to print
#
function Global:dk_fixme($message){
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	#$allArgs = $PsBoundParameters.Values + $args
	
	
	if($ENABLE_dk_fixme -ne 1){ return }

	if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
	dk_echo "${yellow}${FIXME_TAG}${message}${clr}"	
	if($TRACE_ON_FIXME){ dk_echo "${red}*** TRACE_ON_FIXME ***${clr}"; dk_stacktrace }
	if($LINE_ON_FIXME){  dk_echo "${red}*** LINE_ON_FIXME ***${clr}";  dk_showFileLine $(__FILE__ 1) $(__LINE__ 1) }
	if($PAUSE_ON_FIXME){ dk_echo "${red}*** PAUSE_ON_FIXME ***${clr}"; dk_pause }
	if($HALT_ON_FIXME){  dk_echo "${red}*** HALT_ON_FIXME ***${clr}";  dk_exit }
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_fixme "test dk_fixme message"
}
