dk_load(Color)

# DKERROR(msg)
#
macro(DKERROR msg)
	dk_call(dk_updateLogInfo)
	message(STATUS ${H_black}${STACK_HEADER}${CLR}${white}${msg}${CLR})
endmacro()
