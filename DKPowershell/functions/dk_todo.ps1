if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_todo){ $dk_todo = 1 } else{ return }

if(!$ENABLE_dk_todo){ $global:ENABLE_dk_todo = 1 }
if(!$TRACE_ON_TODO) { $global:TRACE_ON_TODO = 0  }
if(!$LINE_ON_TODO)  { $global:LINE_ON_TODO = 0   }
if(!$PAUSE_ON_TODO) { $global:PAUSE_ON_TODO = 0  }
if(!$HALT_ON_TODO)  { $global:HALT_ON_TODO = 0   }
$global:TODO_TAG = "  TODO: "
##################################################################################
# dk_todo(message)
#
#	Print a todo message to the console
#
#	@msg	- The message to print
#
function Global:dk_todo () {
	dk_debugFunc	
	$allArgs = $PsBoundParameters.Values + $args
	
	
	if($ENABLE_dk_todo -ne 1){ return }
	
	$header = "${inverse}$(__FILE__ 1):$(__LINE__ 1)  $(__FUNCTION__ 2)"
	dk_echo "${yellow}${TODO_TAG}${header}  `"${allArgs}`" ${clr}"
	if($TRACE_ON_TODO){ dk_echo "${yellow}*** TRACE_ON_TODO ***${clr}"; dk_stacktrace }
	if($LINE_ON_TODO) { dk_echo "${yellow}*** LINE_ON_TODO ***${clr}";  dk_showFileLine $(__FILE__ 1) $(__LINE__ 1) }
	if($PAUSE_ON_TODO){ dk_echo "${yellow}*** PAUSE_ON_TODO ***${clr}"; dk_pause }
	if($HALT_ON_TODO) { dk_echo "${yellow}*** HALT_ON_TODO ***${clr}";  dk_exit }
}







function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_todo "test dk_todo message"
}
