dk_load(Color)

# dk_error(msg)
#
macro(dk_error)
	dk_call(dk_updateLogInfo)
	message(STATUS ${H_black}${STACK_HEADER}${CLR}${white}${ARGV}${CLR})
endmacro()
macro(DKERROR)
	dk_error(${ARGV})
endmacro()
