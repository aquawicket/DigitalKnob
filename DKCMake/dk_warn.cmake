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
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow}${msg}${CLR}")
endmacro()
#macro(DKWARN)
#	dk_warn(${ARGV})
#	#dk_call(dk_warn ${ARGV})
#endmacro()