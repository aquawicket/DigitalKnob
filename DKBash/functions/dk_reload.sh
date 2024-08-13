#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_reload()
#
#
dk_reload() {
	dk_debugFunc 0

	dk_call dk_debug "reloading ${DKSCRIPT_PATH}"
	dk_call dk_clearScreen
	
	#FIXME: need to unset any and all include guards here.
	#       Or better yet, we need to clear the entire environment
	dk_call dk_unset DKINIT
	
	if [ -n "$(command -v bash)" ]; then
		echo "exec /bin/bash ${DKSCRIPT_PATH}"
		exec /bin/bash "${DKSCRIPT_PATH}"
	else
		echo "exec ${DKSCRIPT_PATH}"
		exec "${DKSCRIPT_PATH}"
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_reload
}
