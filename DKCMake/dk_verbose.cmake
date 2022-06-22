include_guard()
dk_load(dk_color) #TODO:  move this into the function

##################################################################################
# dk_verbose(msg)
#
#	Print a verbose message to the console
#
#	@msg:(required) The message to print
#
macro(dk_verbose msg)
	#message(STATUS "dk_verbose(${ARGV})")
	string(REPLACE " " "" var ${msg})
	dk_call(dk_updateLogInfo)
	if(${var})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${magenta}VARIABLE: \${${var}} = ${${var}}${CLR}")
	else()
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${magenta}${msg}${CLR}")
	endif()
endmacro()
