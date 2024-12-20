#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


##################################################################################
# dk_basename(path, rtn_var)
#
#
function(dk_basename path rtn_var)
	dk_debugFunc()
	if(NOT ${ARGC} EQUAL 2)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	get_filename_component(basename "${path}" NAME)
	#dk_printVar(basename)
	set(${rtn_var} ${basename} PARENT_SCOPE)
	#dk_printVar(rtn_var)
endfunction()



function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc()
	
	
	dk_basename("/path/to/a/filename.txt" basename)
	dk_info("basename of /path/to/a/filename.txt = ${basename}")
endfunction()