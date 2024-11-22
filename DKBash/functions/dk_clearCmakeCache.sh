#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_clearCmakeCache(path)
#
#
dk_clearCmakeCache() {
	dk_debugFunc 1

	dk_call dk_info "Deleting CMake cache files in ${1}"
	
	dk_call dk_delete "${1}/CMakeFiles"
	dk_call dk_delete "${1}/CMakeCache.txt"
	dk_call dk_delete "${1}/cmake_install.cmake"
	
#	find ${CMAKE_BINARY_DIR} -name "CMakeCache.*" -delete
#	rm -rf $(find ${CMAKE_BINARY_DIR} -type d -name CMakeFiles)
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_clearCmakeCache "/C/Users/Administrator/digitalknob/Development/DKApps/HelloWorld/win_x86_64_clang/Debug"
}
