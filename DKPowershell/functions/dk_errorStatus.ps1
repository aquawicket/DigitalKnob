if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_errorStatus){ $dk_errorStatus = 1 } else{ return }


##################################################################################
# dk_errorStatus()
#
#
function Global:dk_errorStatus(){
	dk_debugFunc
	
	
	dk_echo "$(__FILE__ 1):$(__LINE__ 1) ERROR_STATUS = $?"
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_errorStatus
}