include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


#dk_set(ENABLE_dk_todo 0)
#dk_set(TRACE_ON_TODO 1)
#dk_set(LINE_ON_TODO 1)
#dk_set(PAUSE_ON_TODO 1)
#dk_set(HALT_ON_TODO 1)
#dk_set(TODO_TAG " TODO: ")
###############################################################################
# dk_todo(msg)
#
#	@msg (optional)	- A header message to print
#
function(dk_todo)
	dk_debugFunc(${ARGV})
	
	
	if(NOT DEFINED ENABLE_dk_todo)
		set(ENABLE_dk_todo 1 CACHE INTERNAL "")
	endif()
	if(NOT ${ENABLE_dk_todo})
		return()
	endif()
	
	#set(msg "${ARGV}")
	set(msg "${CMAKE_CURRENT_FUNCTION}")
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	if(NOT DEFINED TODO_TAG)
		set(TODO_TAG " TODO: " CACHE INTERNAL "")
	endif()
	
	if(${HALT_ON_TODO} OR HALT AND NOT NO_HALT)
		message("${yellow}*** HALT_ON_TODO ***")
		message(FATAL_ERROR "${TODO_TAG}${${yellow}}${msg}${clr}")
		#dk_exit(1)
	elseif(${TRACE_ON_TODO} OR TRACE AND NOT NO_TRACE)
		message("${yellow}*** TRACE_ON_TODO ***")
		message(WARNING "${TODO_TAG}${clr}${${yellow}}${msg}${clr}")
	else()
		message("${yellow}${TODO_TAG}${msg}${clr}")
	endif()
	
	if(${PAUSE_ON_TODO} OR PAUSE AND NOT NO_PAUSE)
		message("${yellow}*** PAUSE_ON_TODO ***${clr}")
		dk_pause()
	endif()
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo("test dk_todo message")
endfunction()