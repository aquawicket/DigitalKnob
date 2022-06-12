DKLoad(Color)

# DKVERBOSE(msg)
#
macro(DKVERBOSE msg)
	DKCall(dk_updateLogInfo)
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${magenta}${msg}${CLR}")
endmacro()
