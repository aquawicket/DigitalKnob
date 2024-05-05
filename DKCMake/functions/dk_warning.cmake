include_guard()


if(NOT DEFINED ENABLE_dk_warning)
	set(ENABLE_dk_warning 1 CACHE INTERNAL "")
endif()
if(NOT DEFINED TRACE_ON_WARNING)
	set(TRACE_ON_WARNING 1 CACHE INTERNAL "")
endif()
if(NOT DEFINED PAUSE_ON_WARNING)
	set(PAUSE_ON_WARNING 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED HALT_ON_WARNING)
	set(HALT_ON_WARNING 0 CACHE INTERNAL "")
endif()
##################################################################################
# dk_warning(msg)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
function(dk_warning msg)
	#dk_debugFunc(${ARGV})
	
	if(NOT ENABLE_dk_warning)
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
	#message("${H_black}${STACK_HEADER}${clr}${yellow}${msg}${clr}")	
	if(HALT_ON_WARNING OR HALT AND NOT NO_HALT)
		message("${yellow}*** HALT_ON_WARNING ***${clr}")
		message("${yellow}")
		message(FATAL_ERROR "${H_yellow}${msg}${clr}${yellow}")
		message("${clr}")
		#dk_exit(1)
	else()
		if(TRACE_ON_WARNING OR TRACE AND NOT NO_TRACE)
			message("${yellow}")
			message(WARNING "${H_yellow}${msg}${clr}${yellow}")
			message("${clr}")
		else()
			message("${yellow}")
			message("${H_yellow}${msg}${clr}${yellow}")
			message("${clr}")
		endif()
	endif()

	if(PAUSE_ON_WARNING OR PAUSE AND NOT NO_PAUSE)
		message("${yellow}*** PAUSE_ON_WARNING ***${clr}")
		dk_pause()
	endif()
endfunction()
