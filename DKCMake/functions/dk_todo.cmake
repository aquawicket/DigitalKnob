include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()


if(NOT DEFINED ENABLE_dk_todo)
	set(ENABLE_dk_todo 1 CACHE INTERNAL "")
endif()
if(NOT DEFINED TRACE_ON_TODO)
	set(TRACE_ON_TODO 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED PAUSE_ON_TODO)
	set(PAUSE_ON_TODO 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED HALT_ON_TODO)
	set(HALT_ON_TODO 0 CACHE INTERNAL "")
endif()
set(TODO_TAG "  TODO: " CACHE INTERNAL "")
###############################################################################
# dk_todo(msg)
#
#
#	@msg (optional)	- A header message to print
#
function(dk_todo)
	dk_debugFunc(${ARGV})
	
	if(NOT ${ENABLE_dk_todo})
		return()
	endif()
	
	set(msg "${ARGV}")
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	if(${HALT_ON_TODO} OR HALT AND NOT NO_HALT)
		message("${yellow}*** HALT_ON_TODO ***")
		message(FATAL_ERROR "${TODO_TAG}${H_yellow}${msg}${clr}")
		#dk_exit(1)
	elseif(${TRACE_ON_TODO} OR TRACE AND NOT NO_TRACE)
		message("${yellow}*** TRACE_ON_TODO ***")
		message(WARNING "${TODO_TAG}${clr}${H_yellow}${msg}${clr}")
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
endfunction(DKTEST)