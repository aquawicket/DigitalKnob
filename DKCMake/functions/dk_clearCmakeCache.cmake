#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_clearCmakeCache(dir)
#
#   Clear the cmake cache files recursivley for the given directory
#
function(dk_clearCmakeCache)
	dk_debugFunc(1)
	
    dk_info("Deleting CMake cache files in ${ARGV0}")

	dk_delete("${ARGV0}/CMakeFiles")
	dk_delete("${ARGV0}/CMakeCache.txt")
	dk_delete("${ARGV0}/cmake_install.cmake")
	
	#dk_delete("${path}/DKCMAKE_END_VARIABLES.temp")
	#dk_delete("${path}/DKCMAKE_FLAG_VARIABLES.temp")
	#dk_delete("${path}/DKCMAKE_PROJECT_VARIABLES.temp")
	#dk_delete("${path}/DKCMAKE_START_VARIABLES.temp")
	#dk_delete("${path}/DKBUILD.log")
endfunction()













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_clearCmakeCache("C:/Users/Administrator/digitalknob/Development/DKApps/HelloWorld/win_x86_64_clang/Debug")
endfunction()
