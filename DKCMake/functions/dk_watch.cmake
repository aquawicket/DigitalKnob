#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

include(${DKCMAKE_FUNCTIONS_DIR}/dk_watchCallback.cmake)
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
#include_guard()

include($ENV{DKCMAKE_FUNCTIONS_DIR}/dk_watchCallback.cmake)
>>>>>>> Development
##############################################################################
# dk_watch(variable)
# 
#	Watch a varible reading and writing access events
#
#	@variable	- The variable to watch
#
macro(dk_watch variable)
	#dk_debugFunc()
	
#	if(DEFINED ${variable})
		variable_watch(${variable} dk_watchCallback)
#	else()
#		dk_warning("variable:${variable} is undefined")
#	endif()
	
endmacro()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	#dk_watch(CMAKE_CURRENT_FUNCTION_LIST_FILE)
	dk_watch(CMAKE_CURRENT_FUNCTION_LIST_LINE)
=======
	dk_debugFunc(0)
	
	#dk_watch(CMAKE_CURRENT_FUNCTION_LIST_FILE)
	#dk_watch(CMAKE_CURRENT_FUNCTION_LIST_LINE)
>>>>>>> Development
	#dk_watch(CMAKE_CURRENT_FUNCTION)

endfunction()