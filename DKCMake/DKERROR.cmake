DKLoad(Color)

# DKERROR(msg)
#
macro(DKERROR msg)
	DKCall(dk_updateLogInfo)
	message(STATUS ${H_black}${STACK_HEADER}${CLR}${white}${msg}${CLR})
endmacro()
