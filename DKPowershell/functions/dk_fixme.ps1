if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_fixme){ $dk_fixme = 1 } else{ return }

dk_load dk_echo
dk_load dk_stacktrace
dk_load dk_showFileLine
dk_load dk_pause
dk_load dk_exit
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
function Global:dk_fixme () {
	dk_debugFunc
	$allArgs = $PsBoundParameters.Values + $args
	
	
	if($ENABLE_dk_fixme -ne 1){ return }

	$header = "${inverse}$(__FILE__ 1):$(__LINE__ 1)  $(__FUNCTION__ 2)"
	dk_echo "${yellow}${FIXME_TAG}${header}${allArgs}${clr}"	
	if($TRACE_ON_FIXME){ dk_echo "${red}*** TRACE_ON_FIXME ***${clr}"; dk_stacktrace }
	if($LINE_ON_FIXME){  dk_echo "${red}*** LINE_ON_FIXME ***${clr}";  dk_showFileLine $(__FILE__ 1) $(__LINE__ 1) }
	if($PAUSE_ON_FIXME){ dk_echo "${red}*** PAUSE_ON_FIXME ***${clr}"; dk_pause }
	if($HALT_ON_FIXME){  dk_echo "${red}*** HALT_ON_FIXME ***${clr}";  dk_exit }
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_fixme "test dk_fixme message"
}
