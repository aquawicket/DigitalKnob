include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


##################################################################################
# dk_error(msg)
#
#	Print a error message to the console
#
#	@msg	- The message to print
#
macro(dk_error msg)
	#message(STATUS "dk_error(${ARGV})")
	dk_updateLogInfo()
	if(${HALT_ON_ERRORS})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${red} *** HALT_ON_ERRORS *** ${CLR}")
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${red} ${msg} ${CLR}")
		dk_exit()
	endif()
	
	string(REPLACE " " "" var ${msg})
	if(${var})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${red} { \"${var}\" : \"${${var}}\" } ${CLR}")
	else()
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${red} ${msg} ${CLR}")
	endif()
	
	if(${WAIT_ON_ERRORS})
		dk_wait(10)
	endif()
endmacro()
