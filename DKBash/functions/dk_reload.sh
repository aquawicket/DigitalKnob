#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

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
	dk_call dk_unset DKBASH_DIR
	dk_call dk_unset SUDO_EXE
	dk_call dk_unset CMD_EXE
	dk_call dk_unset CYGPATH_EXE
	dk_call dk_unset WSLPATH_EXE
	dk_call dk_unset DKHOME_DIR
	dk_call dk_unset DKCACHE_DIR

printenv
dk_call dk_pause

#	if (command -v bash); then
		dk_call dk_clearScreen
		exec /bin/bash "${DKSCRIPT_PATH}"
#	else
#		dk_call dk_clearScreen
#		exec "${DKSCRIPT_PATH}"
#	fi
	
	###### METHOD 1 ######
#	dk_call dk_fileWrite "${DKBASH_DIR}/reload" "${DKSCRIPT_PATH}"
#	dk_call dk_exit 0
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pause "Press Enter key to test dk_reload"
	dk_call dk_reload
}
