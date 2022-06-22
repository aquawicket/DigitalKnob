include_guard()
dk_load(dk_color) #TODO:  move this into the function

##################################################################################
# dk_info(msg)
#
#	Print a info message to the console
#
#	@msg:(required) The message to print
#
macro(dk_info msg)
	#message(STATUS "dk_info(${ARGV})")
	string(REPLACE " " "" var ${msg})
	dk_call(dk_updateLogInfo)
	if(${var})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${white}VARIABLE: \${${var}} = ${${var}}${CLR}")
	else()
		message(STATUS ${H_black}${STACK_HEADER}${CLR}${white}${msg}${CLR})
	endif()
endmacro()
