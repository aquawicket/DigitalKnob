DKLoad(Color)

# DKDEBUG(msg)
#
macro(DKDEBUG msg)
	DKCall(dk_updateLogInfo)
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${cyan}${msg}${CLR}")
endmacro()
