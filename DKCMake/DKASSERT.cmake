# DKASSERT(msg)
#
macro(DKASSERT msg)
	DKCall(dk_updateLogInfo)
	message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red}${msg}${CLR}")
	DKCall(dk_exit)
endmacro()
