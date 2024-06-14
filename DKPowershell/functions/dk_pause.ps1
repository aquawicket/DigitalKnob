if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_pause){ $dk_pause = 1 } else{ return }

dk_load dk_error
dk_load dk_info
##################################################################################
# dk_pause()
#
#    Pause execution and wait for <enter> keypress to continue
#
function GLOBAL:dk_pause() {
	dk_debugFunc

	Read-Host -Prompt "Press Enter to continue"
}




function Global:DKTEST() { ###########################################################################################
	dk_debugFunc
	
	dk_pause
}