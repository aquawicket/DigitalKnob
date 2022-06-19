dk_load(Color)

# dk_trace(msg)
#
macro(dk_trace)
	dk_call(dk_updateLogInfo)
	message(WARNING "${H_black}${STACK_HEADER}${CLR}${B_blue}${ARGV}${CLR}")
endmacro()
macro(DKTRACE)
	dk_trace(${ARGV})
endmacro()