include_guard()
dk_load(dk_color)

##################################################################################
# dk_error(msg)
#
#	Print a error message to the console
#
#	@msg:(required) The message to print
#
macro(dk_error msg)
	dk_call(dk_updateLogInfo)
	if(${HALT_ON_ERRORS})
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red}${msg}${CLR}")
		dk_call(dk_exit)
	endif()
	message(STATUS ${H_black}${STACK_HEADER}${CLR}${white}${msg}${CLR})
endmacro()
