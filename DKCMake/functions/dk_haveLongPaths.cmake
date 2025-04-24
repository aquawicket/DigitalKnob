#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development


##################################################################################
# dk_haveLongPaths(rtn_var)
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
function(dk_haveLongPaths rtn_var)
	dk_debugFunc()
	
	#if (CMAKE_SYSTEM_NAME MATCHES "Windows")
    if (WIN32_LONG_PATHS)
        message("Long paths are enabled")
		set(${rtn_var} 1 PARENT_SCOPE)
    else()
        message("Long paths are not enabled")
		set(${rtn_var} 0 PARENT_SCOPE)
    endif()
	
	#endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_haveLongPaths(longPaths)
	dk_printVar(longPaths)
endfunction()















