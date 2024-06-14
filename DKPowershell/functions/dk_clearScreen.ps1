if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_clearScreen){ $dk_clearScreen = 1 } else{ return }

##################################################################################
# dk_clearScreen()
#
#
function Global:dk_clearScreen () {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	clear
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_clearScreen
}