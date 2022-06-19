dk_load(Color)

# dk_warn(msg)
#
macro(dk_warn msg)
	dk_call(dk_updateLogInfo)
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow}${msg}${CLR}")
endmacro()
macro(DKWARN)
	dk_warn(${ARGV})
endmacro()