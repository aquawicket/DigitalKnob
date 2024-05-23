if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_pause){ $dk_pause = 1 } else{ return }

dk_load dk_error
dk_load dk_info
##################################################################################
# dk_pause()
#
#    Pause execution and wait for <enter> keypress to continue
#
function GLOBAL:dk_pause() {
	dk_debugFunc
#	$__FUNCTION__ = [string]($(Get-PSCallStack)[0].FunctionName).Split(':')[1]
	if ( $args ){ dk_error "$__FUNCTION__(): incorrect number of arguments" }
	

	dk_functionName
	#dk_info "test"
	
 
	Write-Output "FILENAME = $FILENAME"
	Write-Output "LINENO = $LINENO"
	Write-Output "FUNCTION = $FUNCTION"
	Write-Output "ARGC = $ARGC"
	Read-Host -Prompt "Press Enter to continue"
}




function Global:DKTEST() { ###########################################################################################
	
	dk_pause
}