include_guard()

if(NOT DEFINED TRACE_ON_ERRORS)
	set(TRACE_ON_ERRORS 1 CACHE INTERNAL "")
endif()
if(NOT DEFINED PAUSE_ON_ERRORS)
	set(PAUSE_ON_ERRORS 1 CACHE INTERNAL "")
endif()
if(NOT DEFINED CONTINUE_ON_ERRORS)
	set(CONTINUE_ON_ERRORS 0 CACHE INTERNAL "")
endif()
##################################################################################
# dk_error(msg) NOASSERT
#
#	Print a error message to the console
#
#	@msg	- The message to print
#
function(dk_error msg)
	#DKDEBUGFUNC(${ARGV})
	
	dk_get_option(NOASSERT ${ARGV})
	
	dk_printvar(msg)
	
	dk_dumpAllVariables(${CMAKE_BINARY_DIR}/dk_trace_variables.temp)
	
	dk_updateLogInfo()
	if(NOASSERT)
		message(STATUS "${H_black}${STACK_HEADER}${clr}${red} ${msg} ${clr}")
	else()
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${clr}${red} ${msg} ${clr}")
		#dk_exit(1)
	endif()

	if(PAUSE_ON_ERRORS)
		dk_pause()
		dk_wait()
	endif()
endfunction()
