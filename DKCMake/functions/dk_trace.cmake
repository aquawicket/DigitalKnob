include_guard()

##################################################################################
# dk_trace(msg)
#
#	Print the trace stack with a message to the console
#
#	@msg	- The message to print
#
macro(dk_trace msg)
	#message(STATUS "dk_trace(${ARGV})")
	dk_updateLogInfo()
	string(REPLACE " " "" var ${msg})
	if(${var})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${B_blue} { \"${var}\" : \"${${var}}\" } ${CLR}")
	else()
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${B_blue} ${msg} ${CLR}")
	endif()
endmacro()
