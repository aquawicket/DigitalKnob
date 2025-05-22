#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_clearCmakeCache(path)
#
#   Clear the cmake cache files recursivley for the given directory
#
function(dk_clearCmakeCache)
	dk_debugFunc(1)
	
    dk_info("Deleting CMake cache files in ${ARGV0}")

	dk_delete("${ARGV0}/CMakeFiles")
	dk_delete("${ARGV0}/CMakeCache.txt")
	dk_delete("${ARGV0}/cmake_install.cmake")
endfunction()













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_clearCmakeCache("C:/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/Windows_X86_64_Clang/Debug")
endfunction()
