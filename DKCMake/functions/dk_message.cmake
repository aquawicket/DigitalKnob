include_guard()
#dk_load(dk_color)

##################################################################################
# dk_message(msg)
#
#	Print a STATUS message to the console
#
#	@msg	- The message to print
#
macro(dk_message msg)
	#DKDEBUGFUNC(${ARGV})
	
	string(REPLACE " " "" var ${msg})
	dk_call(dk_updateLogInfo)
	if(${var})
		message(STATUS "${H_black}${STACK_HEADER}${clr} { \"${var}\" : \"${${var}}\" } ")
	else()
		message(STATUS "${H_black}${STACK_HEADER}${clr} ${msg} ")
	endif()
endmacro()
