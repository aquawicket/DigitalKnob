include_guard()
dk_load(dk_color) #TODO:  move this into the function

##################################################################################
# dk_trace(msg)
#
#	Print the trace stack with a message to the console
#
#	@msg:(required) The message to print
#
macro(dk_trace msg)
	#message(STATUS "dk_trace(${ARGV})")
	dk_call(dk_updateLogInfo)
	string(REPLACE " " "" var ${msg})
	if(${var})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${B_blue}VARIABLE: \${${var}} = ${${var}}${CLR}")
	else()
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${B_blue}${msg}${CLR}")
	endif()
endmacro()
