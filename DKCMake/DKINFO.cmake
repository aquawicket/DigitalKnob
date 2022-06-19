dk_load(Color)

# DKINFO(msg)
#
macro(DKINFO msg)
	dk_call(dk_updateLogInfo)
	message(STATUS ${H_black}${STACK_HEADER}${CLR}${white}${msg}${CLR})
endmacro()
