#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development


##################################################################################
# dk_getFullPath(path, rtn_var)
#
#
function(dk_getFullPath path rtn_var)
<<<<<<< HEAD
	dk_debugFunc()
	if(NOT ${ARGC} EQUAL 2)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
=======
	dk_debugFunc(2)
>>>>>>> Development
	
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