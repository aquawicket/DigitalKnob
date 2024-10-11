#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_clearCmakeCache()
#
#
dk_clearCmakeCache() {
	dk_debugFunc 0

	# TODO: replace ${DKBRANCH_DIR} with ${1} and call this functions while suplying the directory 
	dk_call dk_info "Clearing CMake cache . . ."
	#dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	#find ${DKBRANCH_DIR} -name "CMakeCache.*" -delete
	#rm -rf $(find ${DKBRANCH_DIR} -type d -name CMakeFiles)
	
	[ ! -e "${CMAKE_BINARY_DIR}" ] && return
	find ${CMAKE_BINARY_DIR} -name "CMakeCache.*" -delete
	rm -rf $(find ${CMAKE_BINARY_DIR} -type d -name CMakeFiles)
	
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_clearCmakeCache
}
