DKLoad(Color)

# DKDEBUG(msg)
#
macro(DKDEBUG msg)
	if(DKDEBUG_ENABLED)
		DKCall(dk_updateLogInfo)
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${cyan}${msg}${CLR}")
	endif()
endmacro()
