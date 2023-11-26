include_guard()

##################################################################################
# dk_assert(msg)
#
#	Print an assert message to the console and halts execution
#
#	@msg	- The message to print
#
macro(dk_assert msg)
	#message(STATUS "dk_assert(${ARGV})")
	string(REPLACE " " "" var ${msg})
	dk_updateLogInfo()
	if(${var})
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red} { \"${var}\" : \"${${var}}\" } ${CLR}")
	else()
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red} ${msg} ${CLR}")
	endif()
	dk_exit() #FIXME:  is this needed?
endmacro()
