#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


##################################################################################
# dk_getFullPath(path, rtn_var)
#
#
function(dk_getFullPath path rtn_var)
	dk_debugFunc("\${ARGV}")
	if(NOT ${ARGC} EQUAL 2)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	get_filename_component(fullpath ${path} ABSOLUTE)    # ABSOLUTE = Full path to file
	#get_filename_component(fullpath ${path} REALPATH)	 # REALPATH = Full path to existing file with symlinks resolved
	#dk_printVar(fullpath)
	set(${rtn_var} ${fullpath} PARENT_SCOPE)
endfunction()



function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc("\${ARGV}")
	
	dk_getFullPath("bash" fullPath)
	dk_info("fullPath = ${fullPath}")
endfunction()