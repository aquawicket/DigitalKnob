#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


##################################################################################
# dk_todo(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a todo message to the console
#
#	@msg	- The message to print
#
macro(dk_todo)
	dk_debugFunc()

	dk_stacktrace()
	dk_log(TODO "'${ARGV0}'")
endmacro()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc()
	
	dk_todo("test dk_todo message")
endfunction()
