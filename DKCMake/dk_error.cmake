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
	message(STATUS ${H_black}${STACK_HEADER}${CLR}${white}${msg}${CLR})
endmacro()
#macro(DKERROR)
#	dk_error(${ARGV})
#	#dk_call(dk_error ${ARGV})
#endmacro()
