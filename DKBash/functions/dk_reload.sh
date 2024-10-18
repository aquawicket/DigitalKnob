#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_reload()
#
#
dk_reload() {
	dk_debugFunc 0

	dk_call dk_assertPath DKSCRIPT_PATH
	dk_call dk_info "reloading ${DKSCRIPT_PATH}. . ."

	#dk_call dk_clearScreen
	
	###### METHOD 1 ######
	# Clear the environment and reload script
	BASH_EXE=${BASH}
	exec env -i HOME="$HOME" PATH="$PATH" DKSCRIPT_PATH="${DKSCRIPT_PATH}" bash -l -c '${DKSCRIPT_PATH}'

	###### METHOD 2 ######
	# Replace the current process
	#exec /bin/bash "${DKSCRIPT_PATH}"
	
	###### METHOD 3 ######
	# Exit and realod upon reload file detection
	#dk_call dk_fileWrite "${DKBASH_DIR}/reload" "${DKSCRIPT_PATH}"
	#dk_call dk_exit 0
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pause "Press Enter key to test dk_reload"
	dk_call dk_reload
}
