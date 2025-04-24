#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_getUnixPath(path unix_path)
#
#	@path		 	- windows in path
#   @unix_path		- The returned unix style path
#
function(dk_getUnixPath path unix_path)
	dk_debugFunc()
<<<<<<< HEAD
	
	
	if(WIN32)
		dk_depend(MSYS2)
=======

	if(WIN32)
		dk_validate(MSYS2 "dk_depend(msys2)")
>>>>>>> Development
		execute_process(COMMAND cygpath.exe "${path}" OUTPUT_VARIABLE ${unix_path} OUTPUT_STRIP_TRAILING_WHITESPACE)
		string (STRIP ${unix_path} unix_path)
	endif(WIN32)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()