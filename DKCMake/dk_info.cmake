include_guard()
dk_load(dk_color)

##################################################################################
# dk_info(msg)
#
#	Print a info message to the console
#
#	@msg:(required) The message to print
#
macro(dk_info msg)
	dk_call(dk_updateLogInfo)
	message(STATUS ${H_black}${STACK_HEADER}${CLR}${white}${msg}${CLR})
endmacro()
#macro(DKINFO)
#	dk_info(${ARGV})
#	#dk_call(dk_info ${ARGV})
#endmacro()
