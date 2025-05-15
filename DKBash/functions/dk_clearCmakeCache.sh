#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


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
	
	dk_call dk_clearCmakeCache "/C/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/Win_X86_64_Clang/Debug"
}
