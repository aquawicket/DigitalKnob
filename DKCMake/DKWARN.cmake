DKLoad(Color)

# DKWARN(msg)
#
macro(DKWARN msg)
	DKCall(dk_updateLogInfo)
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow}${msg}${CLR}")
endmacro()