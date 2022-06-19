dk_load(Color)

# dk_trace(msg)
#
macro(dk_trace msg)
	dk_call(dk_updateLogInfo)
	message(WARNING "${H_black}${STACK_HEADER}${CLR}${B_blue}${msg}${CLR}")
endmacro()
macro(DKTRACE)
	dk_trace(${ARGV})
endmacro()