#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


##################################################################################
# dk_basename(path, rtn_var)
#
#
function(dk_basename path rtn_var)
	dk_debugFunc(2)
	set(path ${ARGV0})
	set(rtn_var ${ARGV1})
	
	get_filename_component(basename "${path}" NAME)
	set(${rtn_var} ${basename} PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
	
	dk_basename("/path/to/a/filename.txt" basename)
	dk_info("basename of /path/to/a/filename.txt = ${basename}")
endfunction()