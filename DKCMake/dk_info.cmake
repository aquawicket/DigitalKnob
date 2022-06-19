dk_load(Color)

# dk_info(msg)
#
macro(dk_info)
	dk_call(dk_updateLogInfo)
	message(STATUS ${H_black}${STACK_HEADER}${CLR}${white}${ARGV}${CLR})
endmacro()
macro(DKINFO)
	dk_info(${ARGV})
endmacro()
