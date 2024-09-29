#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

include(${DKCMAKE_FUNCTIONS_DIR}/dk_watchCallback.cmake)
##############################################################################
# dk_watch(variable)
# 
#	Watch a varible reading and writing access events
#
#	@variable	- The variable to watch
#
macro(dk_watch variable)
	#dk_debugFunc("\${ARGV}")
	
#	if(DEFINED ${variable})
		variable_watch(${variable} dk_watchCallback)
#	else()
#		dk_warning("variable:${variable} is undefined")
#	endif()
	
endmacro()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	#dk_watch(CMAKE_CURRENT_FUNCTION_LIST_FILE)
	dk_watch(CMAKE_CURRENT_FUNCTION_LIST_LINE)
	#dk_watch(CMAKE_CURRENT_FUNCTION)

endfunction()