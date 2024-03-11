include_guard()

##################################################################################
# dk_error(msg) NOASSERT
#
#	Print a error message to the console
#
#	@msg	- The message to print
#
macro(dk_error msg)
	#DKDEBUGFUNC(${ARGV})
	dk_get_option(NOASSERT ${ARGV})
	
	dk_updateLogInfo()
	if(NOASSERT)
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${red}Error: ${msg} ${CLR}")
		#dk_exit()
	else()
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${red}Error: ${msg} ${CLR}")
	endif()

	if(${WAIT_ON_ERRORS})
		dk_wait(10)
	endif()
endmacro()
