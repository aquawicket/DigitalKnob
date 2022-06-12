DKLoad(Color)

# DKINFO(msg)
#
macro(DKINFO msg)
	DKCall(dk_updateLogInfo)
	message(STATUS ${H_black}${STACK_HEADER}${CLR}${white}${msg}${CLR})
endmacro()
