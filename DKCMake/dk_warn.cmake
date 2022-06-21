include_guard()
dk_load(dk_color)

##################################################################################
# dk_warn(msg)
#
#	Print a warning message to the console
#
#	@msg:(required) The message to print
#
macro(dk_warn msg)
	dk_call(dk_updateLogInfo)
	if(${HALT_ON_WARNINGS})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${red}*** HALT_ON_WARNINGS ***${CLR}")
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${yellow}${msg}${CLR}")
		dk_call(dk_exit)
	endif()
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow}${msg}${CLR}")
endmacro()
