include_guard()
dk_load(dk_color)

##################################################################################
# dk_trace(msg)
#
#	Print the trace stack with a message to the console
#
#	@msg:(required) The message to print
#
macro(dk_trace msg)
	dk_call(dk_updateLogInfo)
	message(WARNING "${H_black}${STACK_HEADER}${CLR}${B_blue}${msg}${CLR}")
endmacro()
#macro(DKTRACE)
#	dk_trace(${ARGV})
#	#dk_call(dk_trace ${ARGV})
#endmacro()