#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


##################################################################################
# dk_basename(<path>, <rtn_var:optional>)
#
#
function(dk_basename)
	dk_debugFunc(1 2)
	
	set (path 		"${ARGV0}")
	set (rtn_var	"${ARGV1}")
	
	get_filename_component(fullpath ${path} ABSOLUTE)
	get_filename_component(dk_basename "${fullpath}" NAME)
	set(dk_basename ${dk_basename} PARENT_SCOPE)
	if(rtn_var)
		set(${rtn_var} ${dk_basename} PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
	
	dk_echo("")
	dk_basename("/path/to/a/filename.txt")
	dk_info("basename of /path/to/a/filename.txt = ${dk_basename}")
	
	dk_echo("")
	dk_basename("C:/Windows/System32")
	dk_info("basename of C:/Windows/System32 = ${dk_basename}")
	
	dk_echo("")
	dk_basename("C:/Windows/System32/" myBasename)
	dk_info("basename of C:/Windows/System32/ = ${myBasename}")
endfunction()