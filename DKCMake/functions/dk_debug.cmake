include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()


if(NOT DEFINED ENABLE_dk_debug)
	set(ENABLE_dk_debug 1 CACHE INTERNAL "")
	#dk_set(ENABLE_dk_debug 1)
endif()
if(NOT DEFINED TRACE_ON_DEBUG)
	set(TRACE_ON_DEBUG 0 CACHE INTERNAL "")
	#dk_set(TRACE_ON_DEBUG 0)
endif()
if(NOT DEFINED PAUSE_ON_DEBUG)
	set(PAUSE_ON_DEBUG 0 CACHE INTERNAL "")
	#dk_set(PAUSE_ON_DEBUG 0)
endif()
if(NOT DEFINED HALT_ON_DEBUG)
	set(HALT_ON_DEBUG 0 CACHE INTERNAL "")
	#dk_set(HALT_ON_DEBUG 0)
endif()
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
	
	if(NOT ENABLE_dk_debug)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	if(HALT_ON_DEBUG)
		message("${blue}*** HALT_ON_DEBUG ***${clr}")
		message(FATAL_ERROR "${BLUE}${msg}${clr}")
		#dk_exit(1)
	else()
		if(TRACE_ON_DEBUG)
			message("${blue}*** TRACE_ON_DEBUG ***${clr}")
			message(WARNING "${BLUE}${msg}${clr}")
		else()
			dk_echo("${blue}${msg}${clr}")
		endif()
	endif()
	
	if(PAUSE_ON_DEBUG)
		message("${blue}*** PAUSE_ON_DEBUG ***${clr}")
		dk_pause()
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_debug("test strin from dk_debug")
endfunction(DKTEST)