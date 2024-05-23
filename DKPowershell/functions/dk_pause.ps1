if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_pause){ $dk_pause = 1 } else{ return }

dk_load dk_error
##################################################################################
# dk_pause()
#
#    Pause execution and wait for <enter> keypress to continue
#
function GLOBAL:dk_pause() {
	dk_debugFunc
	$__FUNCTION__ = [string]($(Get-PSCallStack)[0].FunctionName).Split(':')[1]
	if ( $args ){ dk_error "$__FUNCTION__(): incorrect number of arguments" }
	
	Read-Host -Prompt "Press Enter to continue"
}




function Global:DKTEST() { ###########################################################################################
	
	dk_pause
}