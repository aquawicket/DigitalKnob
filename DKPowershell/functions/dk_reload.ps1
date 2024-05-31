if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_reload){ $dk_reload = 1 } else{ return }


##################################################################################
# dk_reload()
#
#
function Global:dk_reload () {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	dk_debug "reloading ${DKSCRIPT_PATH}"
	dk_clearScreen
	
	#FIXME: need to unset any and all include guards here.
	#       Or better yet, we need to clear the entire environment
	unset DKINIT
	
	if("$(command -v bash)"){
		echo "exec /bin/bash ${DKSCRIPT_PATH}"
		exec /bin/bash "${DKSCRIPT_PATH}"
	} else {
		echo "exec ${DKSCRIPT_PATH}"
		exec "${DKSCRIPT_PATH}"
	}
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_reload
}