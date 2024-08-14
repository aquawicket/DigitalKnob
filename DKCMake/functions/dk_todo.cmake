include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


##################################################################################
# dk_todo(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a todo message to the console
#
#	@msg	- The message to print
#
function(dk_todo msg)
	dk_debugFunc(${ARGV})

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





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(${ARGV})
	
	dk_todo("test dk_todo message")
endfunction()
