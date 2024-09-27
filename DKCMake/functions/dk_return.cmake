#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_return()
#
#	Print the current cmake file and return
#
macro(dk_return)
	dk_debugFunc("${ARGV}")
	
	if(PRINT_DKRETURNS)
		dk_debug("${CMAKE_CURRENT_LIST_FILE} -> dk_return()")
	endif()
	return()
endmacro()
dk_createOsMacros("dk_return")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()
