include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


##################################################################################
# dk_warn(msg)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
macro(dk_warn msg)
	#message(STATUS "dk_warn(${ARGV})")
	dk_updateLogInfo()
	if(${HALT_ON_WARNINGS})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow} *** HALT_ON_WARNINGS *** ${CLR}")
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${yellow} ${msg} ${CLR}")
		dk_exit()
	endif()
	
	string(REPLACE " " "" var ${msg})
	if(${var})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow} { \"${var}\" : \"${${var}}\" } ${CLR}")
	else()
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow} ${msg} ${CLR}")
	endif()
	
	if(${WAIT_ON_WARNINGS})
		dk_wait(10)
	endif()
endmacro()
