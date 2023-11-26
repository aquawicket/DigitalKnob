include_guard()

##################################################################################
# dk_info(msg)
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
macro(dk_info msg)
	#message(STATUS "dk_info(${ARGV})")
	string(REPLACE " " "" var ${msg})
	dk_updateLogInfo()
	if(${var})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${white} { \"${var}\" : \"${${var}}\" } ${CLR}")
	else()
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${white} ${msg} ${CLR}")
	endif()
endmacro()
