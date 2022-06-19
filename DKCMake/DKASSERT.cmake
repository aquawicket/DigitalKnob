# DKASSERT(msg)
#
macro(DKASSERT msg)
	dk_call(dk_updateLogInfo)
	message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red}${msg}${CLR}")
	dk_call(dk_exit)
endmacro()
