include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


##################################################################################
# dk_debug(msg)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
macro(dk_debug msg)
	#DKDEBUGFUNC(${ARGV})
	if(DKDEBUG_ENABLED)
		#message(STATUS "dk_debug(${ARGV})")
		string(REPLACE " " "" var "${msg}")
		dk_updateLogInfo()
		if("${var}")
			message(STATUS "${H_black}${STACK_HEADER}${CLR}${cyan} { \"${var}\" : \"${${var}}\" } ${CLR}")
		else()
			message(STATUS "${H_black}${STACK_HEADER}${CLR}${cyan} ${msg} ${CLR}")
		endif()
	endif()
endmacro()
