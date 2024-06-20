include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

include(${DKCMAKE_FUNCTIONS_DIR}/dk_watchCallback.cmake)
##############################################################################
# dk_watch(variable)
# 
#	Watch a varible reading and writing access events
#
#	@variable	- The variable to watch
#
macro(dk_watch variable)
	#dk_debugFunc(${ARGV})
	
	if(DEFINED ${variable})
		variable_watch(${variable} dk_watchCallback)
	else()
		message(FATAL_ERROR "variable:${variable} is undefined")
	endif()
	
endmacro()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_watch(CMAKE_CURRENT_FUNCTION)
	dk_info("123")

endfunction(DKTEST)