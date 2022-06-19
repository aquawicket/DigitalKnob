dk_load(Color)

# DKWARN(msg)
#
macro(DKWARN msg)
	dk_call(dk_updateLogInfo)
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow}${msg}${CLR}")
endmacro()