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

	dk_if(NOT DEFINED ENABLE_dk_todo "set(ENABLE_dk_todo  1        CACHE INTERNAL '')")
	dk_if(NOT DEFINED PAUSE_ON_TODO  "set(PAUSE_ON_TODO   0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED TRACE_ON_TODO  "set(TRACE_ON_TODO   0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED LINE_ON_TODO   "set(LINE_ON_TODO    0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED HALT_ON_TODO   "set(HALT_ON_TODO    0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED TODO_TAG       "set(TODO_TAG       'TODO: '  CACHE INTERNAL '')")

	dk_if(NOT ENABLE_dk_todo "return()")	
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
#	if(NOT echo_fileline)
#		__FILE__(_FILE_ 0)
#		__LINE__(_LINE_ 0)
#		dk_basename("${_FILE_}" _FILE_)
#		set(echo_fileline "${_FILE_}:${_LINE_}   " CACHE INTERNAL "")
#	endif()
	
#	set(msg ${ARGV})
	dk_echo("${yellow}${TODO_TAG}${msg}${clr}")
	
	if((PAUSE_ON_TODO OR PAUSE) AND NOT NO_PAUSE)
		dk_echo("${yellow}*** PAUSE_ON_TODO ***${clr}")
		dk_pause()
	endif()
	if((TRACE_ON_TODO OR TRACE) AND NOT NO_TRACE)
		message(WARNING "${yellow}*** TRACE_ON_TODO ***")
		dk_echo("${clr}")
	endif()
	if((LINE_ON_TODO OR LINE) AND NOT NO_LINE)
		dk_echo("${yellow}*** LINE_ON_TODO ***${clr}")
		dk_echo("LINE_ON_TODO\n")
	endif()
	if((HALT_ON_TODO OR HALT) AND NOT NO_HALT)
		dk_echo("${yellow}*** HALT_ON_TODO ***${clr}")
		dk_exit(0)
	endif()	
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(${ARGV})
	
	set(ENABLE_dk_todo 1)
	set(PAUSE_ON_TODO 1)
	set(TRACE_ON_TODO 1)
	set(LINE_ON_TODO 1)
	set(HALT_ON_TODO 1)
	set(TODO_TAG "DKTEST_TODO: ")
	dk_todo("test dk_todo message")
endfunction()
