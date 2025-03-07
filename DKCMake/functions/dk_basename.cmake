#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


##################################################################################
# dk_basename(path, rtn_var)
#
#
function(dk_basename path rtn_var)
	dk_debugFunc(2)
	
	#dk_getArg(0 path)
	#dk_getArg(1 rtn_var)
	
	get_filename_component(fullpath ${path} ABSOLUTE)
	get_filename_component(basename "${fullpath}" NAME)
	set(${rtn_var} ${basename} PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
	
	dk_basename("/path/to/a/filename.txt" basename)
	dk_info("basename of /path/to/a/filename.txt = ${basename}")
	
	dk_basename("C:/Windows/System32" basename)
	dk_info("basename of C:/Windows/System32 = ${basename}")
	
	dk_basename("C:/Windows/System32/" basename)
	dk_info("basename of C:/Windows/System32/ = ${basename}")
endfunction()