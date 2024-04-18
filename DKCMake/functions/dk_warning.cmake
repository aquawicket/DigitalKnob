include_guard()

##################################################################################
# dk_warning(msg)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
macro(dk_warning msg)
	#DKDEBUGFUNC(${ARGV})
	
	dk_printvar(msg)
	
	dk_updateLogInfo()
	if(${HALT_ON_WARNINGS})
		message(STATUS "${H_black}${STACK_HEADER}${clr}${yellow} *** HALT_ON_WARNINGS *** ${clr}")
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${clr}${yellow} ${msg} ${clr}")
		dk_exit()
	endif()
	
	message(WARNING "${H_black}${STACK_HEADER}${clr}${yellow} ${msg} ${clr}")

	if(${WAIT_ON_WARNINGS})
		dk_wait(10)
	endif()
endmacro()
