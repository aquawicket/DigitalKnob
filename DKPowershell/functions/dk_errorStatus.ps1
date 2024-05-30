if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_errorStatus){ $dk_errorStatus = 1 } else{ return }


##################################################################################
# dk_errorStatus()
#
#
function Global:dk_errorStatus(){
	echo "${BASH_SOURCE} ${LINENO}: ERROR_STATUS = $?"
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_errorStatus
}