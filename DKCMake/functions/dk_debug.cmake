include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
##include_guard()

#dk_set(ENABLE_dk_debug 0)
#dk_set(TRACE_ON_DEBUG 1)
#dk_set(LINE_ON_DEBUG 1)
#dk_set(PAUSE_ON_DEBUG 1)
#dk_set(HALT_ON_DEBUG 1)
#dk_set(DEBUG_TAG " DEBUG: ")
##################################################################################
# dk_debug(msg)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
function(dk_debug msg)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 1)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	
	if(NOT DEFINED ENABLE_dk_debug)
		set(ENABLE_dk_debug 1 CACHE INTERNAL "")
	endif()
	if(NOT ENABLE_dk_debug)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	if(HALT_ON_DEBUG OR HALT AND NOT NO_HALT)
		dk_echo("${blue}*** HALT_ON_DEBUG ***${clr}")
		message(FATAL_ERROR "${blue}${msg}${clr}")
		#dk_exit(1)
	else()
		if(TRACE_ON_DEBUG OR TRACE AND NOT NO_TRACE)
			dk_echo("${blue}*** TRACE_ON_DEBUG ***${clr}")
			message(WARNING "${blue}${msg}${clr}")
		else()
			dk_echo("${blue}${msg}${clr}")
		endif()
	endif()
	
	if(PAUSE_ON_DEBUG OR PAUSE AND NOT NO_PAUSE)
		dk_echo("${blue}*** PAUSE_ON_DEBUG ***${clr}")
		dk_pause()
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_debug("test message from dk_debug")
endfunction()
