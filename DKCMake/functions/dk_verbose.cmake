include_guard()


if(NOT DEFINED ENABLE_dk_verbose)
	set(ENABLE_dk_verbose 1 CACHE INTERNAL "")
endif()
if(NOT DEFINED TRACE_ON_VERBOSE)
	set(TRACE_ON_VERBOSE 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED PAUSE_ON_VERBOSE)
	set(PAUSE_ON_VERBOSE 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED HALT_ON_VERBOSE)
	set(HALT_ON_VERBOSE 0 CACHE INTERNAL "")
endif()
##################################################################################
# dk_verbose(msg)
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
function(dk_verbose msg)
	#DKDEBUGFUNC(${ARGV})
	
	if(NOT ENABLE_dk_verbose)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	dk_printVar(msg)
	#dk_updateLogInfo()
	#message(DEBUG "${H_black}${STACK_HEADER}${clr}${cyan}${msg}${clr}")
	if(HALT_ON_VERBOSE OR HALT AND NOT NO_HALT)
		message("${cyan}*** HALT_ON_VERBOSE ***${clr}")
		message("${cyan}")
		message(FATAL_ERROR "${H_cyan}${msg}${clr}${cyan}")
		message("${clr}")
		#dk_exit(1)
	else()
		if(TRACE_ON_VERBOSE OR TRACE AND NOT NO_TRACE)
			message("${cyan}")
			message(WARNING "${H_cyan}${msg}${clr}${cyan}")
			message("${clr}")
		else()
			message("${cyan}")
			message("${H_cyan}${msg}${clr}${cyan}")
			message("${clr}")
		endif()
	endif()
	
	if(PAUSE_ON_VERBOSE OR PAUSE AND NOT NO_PAUSE)
		message("${cyan}*** PAUSE_ON_VERBOSE ***${clr}")
		dk_pause()
	endif()
endfunction()
