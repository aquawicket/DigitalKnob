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
# dk_getFullPath(path, rtn_var)
#
#
function(dk_getFullPath path rtn_var)
	dk_debugFunc(2)
	
	get_filename_component(fullpath ${path} ABSOLUTE)    # ABSOLUTE = Full path to file
	#get_filename_component(fullpath ${path} REALPATH)	 # REALPATH = Full path to existing file with symlinks resolved
	#dk_printVar(fullpath)
	set(${rtn_var} ${fullpath} PARENT_SCOPE)
endfunction()



function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc()
	
	dk_getFullPath("bash" fullPath)
	dk_info("fullPath = ${fullPath}")
endfunction()