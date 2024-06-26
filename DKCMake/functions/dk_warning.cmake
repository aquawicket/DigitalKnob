include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

#dk_set(ENABLE_dk_warning 0)
#dk_set(TRACE_ON_WARNING 1)
#dk_set(LINE_ON_WARNING 1)
#dk_set(PAUSE_ON_WARNING 1)
#dk_set(HALT_ON_WARNING 1)
#dk_set(WARNING_TAG " WARNING: ")
##################################################################################
# dk_warning(msg)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
function(dk_warning msg)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 1)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	
	if(NOT DEFINED ENABLE_dk_warning)
		set(ENABLE_dk_warning 1 CACHE INTERNAL "")
	endif()
	if(NOT ENABLE_dk_warning)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	if(HALT_ON_WARNING OR HALT AND NOT NO_HALT)
		message("${yellow}*** HALT_ON_WARNING ***")
		message(FATAL_ERROR "${yellow}${msg}${clr}")
		#dk_exit(1)
	else()
		if(TRACE_ON_WARNING OR TRACE AND NOT NO_TRACE)
			message("${yellow}*** TRACE_ON_WARNING ***")
			message(WARNING "${yellow}${msg}${clr}")
			message("${clr}")
		else()
			message("${yellow}${msg}${clr}")
		endif()
	endif()

	if(PAUSE_ON_WARNING OR PAUSE AND NOT NO_PAUSE)
		message("${yellow}*** PAUSE_ON_WARNING ***${clr}")
		dk_pause()
	endif()
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_warning("test message from dk_warning")
endfunction()
