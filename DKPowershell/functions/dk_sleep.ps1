if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_toLower){ $dk_toLower = 1 } else{ return }

####################################################################
# dk_sleep(seconds)
#
function Global:dk_sleep($seconds) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	Start-Sleep -s $seconds
}




function Global:DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_sleep 5
}
