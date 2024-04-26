include_guard()


if(NOT DEFINED ENABLE_dk_info)
	set(ENABLE_dk_info 1 CACHE INTERNAL "")
endif()
if(NOT DEFINED TRACE_ON_INFO)
	set(TRACE_ON_INFO 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED PAUSE_ON_INFO)
	set(PAUSE_ON_INFO 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED HALT_ON_INFO)
	set(HALT_ON_INFO 0 CACHE INTERNAL "")
endif()
##################################################################################
# dk_info(msg)
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
function(dk_info)
	#dk_debugFunc(${ARGV})
	
	set(msg ${ARGV})
	
	if(NOT ENABLE_dk_info)
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
	#message("${H_black}${STACK_HEADER}${clr}${white}${msg}${clr}")
	if(HALT_ON_INFO OR HALT AND NOT NO_HALT)
		message("${white}*** HALT_ON_INFO ***${clr}")
		message("${white}")
		message(FATAL_ERROR "${H_white}${msg}${clr}${white}")
		message("${clr}")
		#dk_exit(1)
	else()
		if(TRACE_ON_INFO OR TRACE AND NOT NO_TRACE)
			message("${white}")
			message(WARNING "${H_white}${msg}${clr}${white}")
			message("${clr}")
		else()
			message("${white}")
			message("${H_white}${msg}${clr}${white}")
			message("${clr}")
		endif()
	endif()
	
	if(PAUSE_ON_INFO OR PAUSE AND NOT NO_PAUSE)
		message("${blue}*** PAUSE_ON_INFO ***${clr}")
		dk_pause()
	endif()
endfunction()
