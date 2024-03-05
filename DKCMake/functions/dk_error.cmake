include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


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
	if(${HALT_ON_ERRORS} AND NOT ${NOASSERT})
		message(STATUS "\n${H_black}${STACK_HEADER}${CLR}${red} *** HALT_ON_ERRORS *** ${CLR}")
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${red}Error: ${msg} ${CLR}")
		#dk_exit()
	endif()
	
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${red}Error: ${msg} ${CLR}")
	
	if(${WAIT_ON_ERRORS})
		dk_wait(10)
	endif()
endmacro()
