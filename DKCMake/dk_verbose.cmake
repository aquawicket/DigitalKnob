include_guard()
dk_load(dk_color)

##################################################################################
# dk_verbose(msg)
#
#	Print a verbose message to the console
#
#	@msg:(required) The message to print
#
macro(dk_verbose msg)
	dk_call(dk_updateLogInfo)
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${magenta}${msg}${CLR}")
endmacro()
#macro(DKVERBOSE)
#	dk_verbose(${ARGV})
#	#dk_call(dk_verbose ${ARGV})
#endmacro()