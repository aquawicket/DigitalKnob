<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

##################################################################################
# dk_reload()
#
#
dk_reload() {
	dk_debugFunc 0

	dk_call dk_assertPath DKSCRIPT_PATH
	dk_call dk_info "reloading ${DKSCRIPT_PATH}. . ."
	
	###### METHOD 1 ######
	# https://superuser.com/a/1333539/600216
	# Clear the environment and reload script
	dk_call dk_freshRun "${DKSCRIPT_PATH}"

	###### METHOD 2 ######
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
