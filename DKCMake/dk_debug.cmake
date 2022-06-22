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
		#message(STATUS "dk_debug(${ARGV})")
		string(REPLACE " " "" var ${msg})
		dk_call(dk_updateLogInfo)
		if(${var})
			message(STATUS "${H_black}${STACK_HEADER}${CLR}${cyan}VARIABLE: \${${var}} = ${${var}}${CLR}")
		else()
			message(STATUS "${H_black}${STACK_HEADER}${CLR}${cyan}${msg}${CLR}")
		endif()
	endif()
endmacro()
