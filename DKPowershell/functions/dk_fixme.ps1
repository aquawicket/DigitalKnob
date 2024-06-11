if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_assert){ $dk_assert = 1 } else{ return }

if(!$ENABLE_dk_fixme){ $global:ENABLE_dk_fixme = 1 }
if(!$TRACE_ON_FIXME) { $global:TRACE_ON_FIXME = 0  }
if(!$LINE_ON_FIXME)  { $global:LINE_ON_FIXME = 0   }
if(!$PAUSE_ON_FIXME) { $global:PAUSE_ON_FIXME = 0  }
if(!$HALT_ON_FIXME)  { $global:HALT_ON_FIXME = 0   }
$FIXME_TAG="  FIXME: "
##################################################################################
# dk_fixme(<message>)
#
#	Print a fixme message to the console
#
#	@msg	- The message to print
#
function Global:dk_fixme () {
	dk_debugFunc
	$allArgs = $PsBoundParameters.Values + $args
	
	if($ENABLE_dk_fixme -ne 1){ return }

	dk_echo "${yellow}${FIXME_TAG-}${allArgs}${clr}"	
	if($TRACE_ON_FIXME){ dk_echo "\n${red}*** TRACE_ON_FIXME ***${clr}" } #&& dk_stacktrace; true #OR TRACE AND NOT NO_TRACE)
	if($TRACE_ON_FIXME){ dk_echo "\n${red}*** LINE_ON_FIXME ***${clr}"  } #&& dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[0]}"; true #OR HALT AND NOT NO_HALT)
	if($TRACE_ON_FIXME){ dk_echo "\n${red}*** PAUSE_ON_FIXME ***${clr}" } #&& dk_pause; true #OR PAUSE AND NOT NO_PAUSE)
	if($TRACE_ON_FIXME){ dk_echo "\n${red}*** HALT_ON_FIXME ***${clr}"  } #&& dk_exit; true #OR HALT AND NOT NO_HALT)
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_fixme "test dk_fixme message"
}
