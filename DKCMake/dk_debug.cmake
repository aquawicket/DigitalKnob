include_guard()
dk_load(dk_color) #TODO:  move this into the function

##################################################################################
# dk_debug(msg)
#
#	Print a debug message to the console
#
#	@msg:(required) The message to print
#
macro(dk_debug msg)
	if(DKDEBUG_ENABLED)
		dk_call(dk_updateLogInfo)
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${cyan}${msg}${CLR}")
	endif()
endmacro()
