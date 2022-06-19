DKLoad(Color)

# DKVERBOSE(msg)
#
macro(DKVERBOSE msg)
	dk_call(dk_updateLogInfo)
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${magenta}${msg}${CLR}")
endmacro()
