dk_load(Color)

# dk_verbose(msg)
#
macro(dk_verbose msg)
	dk_call(dk_updateLogInfo)
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${magenta}${msg}${CLR}")
endmacro()
macro(DKVERBOSE)
	dk_verbose(${ARGV})
endmacro()