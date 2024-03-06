include_guard()

##################################################################################
# dk_warn(msg) PRINTVAR 
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
macro(dk_warn msg)
	#DKDEBUGFUNC(${ARGV})
	dk_get_option(PRINTVAR ${ARGV})
	dk_printvar(msg)
	
	dk_updateLogInfo()
	if(${HALT_ON_WARNINGS})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow} *** HALT_ON_WARNINGS *** ${CLR}")
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${yellow} ${msg} ${CLR}")
		dk_exit()
	endif()
	
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow} ${msg} ${CLR}")

	if(${WAIT_ON_WARNINGS})
		dk_wait(10)
	endif()
endmacro()
