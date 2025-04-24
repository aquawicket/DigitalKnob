<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_clearCmakeCache()
#
#
dk_clearCmakeCache() {
	dk_debugFunc 0

	# TODO: replace ${DKBRANCH_DIR} with ${1} and call this functions while suplying the directory 
	dk_call dk_info "Clearing CMake cache . . ."
	
	dk_call dk_validate DK3RDPARTY_DIR	"dk_call dk_DKBRANCH_DIR"
	dk_call dk_validate DKAPPS_DIR		"dk_call dk_DKBRANCH_DIR"
	dk_call dk_validate DKPLUGINS_DIR	"dk_call dk_DKBRANCH_DIR"
	
	if [ -e "${DK3RDPARTY_DIR}" ]; then
		find ${DK3RDPARTY_DIR} -name "CMakeCache.*" -delete
		rm -rf $(find ${DK3RDPARTY_DIR} -type d -name CMakeFiles)
	fi

	if [ -e "${DKAPPS_DIR}" ]; then
		find ${DKAPPS_DIR} -name "CMakeCache.*" -delete
		rm -rf $(find ${DKAPPS_DIR} -type d -name CMakeFiles)
	fi
	
	if [ -e "${DKPLUGINS_DIR}" ]; then
		find ${DKPLUGINS_DIR} -name "CMakeCache.*" -delete
		rm -rf $(find ${DKPLUGINS_DIR} -type d -name CMakeFiles)
	fi
	
#	[ ! -e "${CMAKE_BINARY_DIR}" ] && return
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

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
	
>>>>>>> Development
#	find ${CMAKE_BINARY_DIR} -name "CMakeCache.*" -delete
#	rm -rf $(find ${CMAKE_BINARY_DIR} -type d -name CMakeFiles)
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
<<<<<<< HEAD
	dk_call dk_clearCmakeCache
=======
	dk_call dk_clearCmakeCache "/C/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/win_x86_64_clang/Debug"
>>>>>>> Development
}
