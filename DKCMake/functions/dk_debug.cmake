include_guard()


if(NOT DEFINED ENABLE_dk_debug)
	set(ENABLE_dk_debug 1 CACHE INTERNAL "")
endif()
if(NOT DEFINED TRACE_ON_DEBUG)
	set(TRACE_ON_DEBUG 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED PAUSE_ON_DEBUG)
	set(PAUSE_ON_DEBUG 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED HALT_ON_DEBUG)
	set(HALT_ON_DEBUG 0 CACHE INTERNAL "")
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
	
	if(NOT ENABLE_dk_debug)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	#dk_updateLogInfo()
	#message(DEBUG "${H_black}${STACK_HEADER}${clr}${blue}${msg}${clr}")
	if(HALT_ON_DEBUG OR HALT AND NOT NO_HALT)
		message("${blue}*** HALT_ON_DEBUG ***${clr}")
		message(FATAL_ERROR "${H_blue}${msg}${clr}")
		#dk_exit(1)
	else()
		if(TRACE_ON_DEBUG OR TRACE AND NOT NO_TRACE)
			message("${blue}*** TRACE_ON_DEBUG ***${clr}")
			message(WARNING "${H_blue}${msg}${clr}")
		else()
			message("${blue}${msg}${clr}")
		endif()
	endif()
	
	if(PAUSE_ON_DEBUG OR PAUSE AND NOT NO_PAUSE)
		message("${blue}*** PAUSE_ON_DEBUG ***${clr}")
		dk_pause()
	endif()
endfunction()
