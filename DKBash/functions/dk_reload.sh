#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_reload()
#
#
dk_reload() {
	dk_debugFunc 0

	[ -e "${DKSCRIPT_PATH}" ] || dk_call dk_error "DKSCRIPT_PATH:${DKSCRIPT_PATH} does not exist" || return 1

	dk_call dk_clearScreen
	dk_call dk_info "reloading ${DKSCRIPT_PATH}. . ."
	

	###### METHOD 2 ######
	#FIXME: need to unset any and all include guards here.
	#       Or better yet, we need to clear the entire environment
	dk_call dk_unset DKINIT
	if [ -n "$(command -v bash)" ]; then
		#echo "exec /bin/bash ${DKSCRIPT_PATH}"
		clear
		exec /bin/bash "${DKSCRIPT_PATH}"
	else
		#echo "exec ${DKSCRIPT_PATH}"
		clear
		exec "${DKSCRIPT_PATH}"
	fi
	
	
	###### METHOD 1 ######
	dk_call dk_fileWrite "${DKBASH_DIR}/reload" "${DKSCRIPT_PATH}"
	dk_call dk_exit 0
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pause "Press Enter key to test dk_reload"
	dk_call dk_reload
}
