#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development


##################################################################################
# dk_todo(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a todo message to the console
#
#	@msg	- The message to print
#
<<<<<<< HEAD
function(dk_todo)
	dk_debugFunc()

	dk_log(TODO "${ARGV0}")
	dk_log(TODO "CMAKE_PARENT_LIST_FILE = ${CMAKE_PARENT_LIST_FILE}")
	dk_log(TODO "CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")
	dk_log(TODO "CMAKE_CURRENT_LIST_FILE = ${CMAKE_CURRENT_LIST_FILE}")
	dk_log(TODO "CMAKE_CURRENT_LIST_LINE = ${CMAKE_CURRENT_LIST_LINE}")
	dk_log(TODO "CMAKE_CURRENT_FUNCTION = ${CMAKE_CURRENT_FUNCTION}")
	dk_log(TODO "CMAKE_CURRENT_FUNCTION_LIST_DIR = ${CMAKE_CURRENT_FUNCTION_LIST_DIR}")
	dk_log(TODO "CMAKE_CURRENT_FUNCTION_LIST_FILE = ${CMAKE_CURRENT_FUNCTION_LIST_FILE}")
	dk_log(TODO "CMAKE_CURRENT_FUNCTION_LIST_LINE = ${CMAKE_CURRENT_FUNCTION_LIST_LINE}")
endfunction()
=======
macro(dk_todo)
	dk_debugFunc()

	dk_stacktrace()
	dk_log(TODO "'${ARGV0}'")
endmacro()
>>>>>>> Development





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc()
	
	dk_todo("test dk_todo message")
endfunction()
