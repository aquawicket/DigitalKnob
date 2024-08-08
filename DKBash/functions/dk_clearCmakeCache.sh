#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_clearCmakeCache()
#
#
dk_clearCmakeCache() {
	dk_debugFunc 0

	
	# TODO: replace ${DIGITALKNOB_DIR} with ${1} and call this functions while suplying the directory 
	dk_info "Clearing CMake cache . . ."	
	find ${DIGITALKNOB_DIR} -name "CMakeCache.*" -delete
	rm -rf $(find ${DIGITALKNOB_DIR} -type d -name CMakeFiles)
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc 0
	
	dk_clearCmakeCache
}