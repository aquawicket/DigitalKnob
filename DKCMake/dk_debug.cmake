dk_load(Color)

# dk_debug(msg)
#
macro(dk_debug)
	if(DKDEBUG_ENABLED)
		dk_call(dk_updateLogInfo)
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${cyan}${ARGV}${CLR}")
	endif()
endmacro()
macro(DKDEBUG)
	dk_debug(${ARGV})
endmacro()
