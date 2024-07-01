include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

#dk_set(ENABLE_dk_todo 0)
#dk_set(TRACE_ON_TODO 1)
#dk_set(LINE_ON_TODO 1)
#dk_set(PAUSE_ON_TODO 1)
#dk_set(HALT_ON_TODO 1)
#dk_set(TODO_TAG " TODO: ")
##################################################################################
# dk_todo(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a todo message to the console
#
#	@msg	- The message to print
#
function(dk_todo) # msg
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 1)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	
	if(NOT DEFINED ENABLE_dk_todo)
		set(ENABLE_dk_todo 1 CACHE INTERNAL "")
	endif()
	if(NOT ENABLE_dk_todo)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	if(NOT DEFINED TODO_TAG)
		set(TODO_TAG " TODO: " CACHE INTERNAL "")
	endif()
	
	if(NOT echo_fileline)
		__FILE__(_FILE_ 0)
		__LINE__(_LINE_ 0)
		dk_getBasename("${_FILE_}" _FILE_)
		set(echo_fileline "${_FILE_}:${_LINE_}   " CACHE INTERNAL "")
	endif()
	
	set(msg ${ARGV})
	if((HALT_ON_TODO OR HALT) AND NOT NO_HALT)
		dk_echo("${yellow}")
		dk_echo("*** HALT_ON_TODO ***")
		message(FATAL_ERROR "${TODO_TAG}${msg}")
		dk_echo("${clr}")
		dk_exit(1)
	else()
		if((TRACE_ON_TODO OR TRACE) AND NOT NO_TRACE)
			dk_echo("${yellow}")
			dk_echo("*** TRACE_ON_TODO ***")
			message(WARNING "${TODO_TAG}${msg}")
			dk_echo("${clr}")
			#dk_dumpAllVariables(${CMAKE_BINARY_DIR}/dk_trace_variables.temp)
		else()
			dk_echo("${yellow}${TODO_TAG}${msg}${clr}")
		endif()
	endif()
	
	if((PAUSE_ON_TODO OR PAUSE) AND NOT NO_PAUSE)
		dk_echo("${yellow}*** PAUSE_ON_TODO ***${clr}")
		dk_pause()
	endif()
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_set(ENABLE_dk_todo 1)
	dk_todo("test dk_todo message")
endfunction()
