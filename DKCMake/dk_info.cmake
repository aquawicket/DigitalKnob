dk_load(Color)

# dk_info(msg)
#
macro(dk_info msg)
	dk_call(dk_updateLogInfo)
	message(STATUS ${H_black}${STACK_HEADER}${CLR}${white}${msg}${CLR})
endmacro()
macro(DKINFO)
	dk_info(${ARGV})
endmacro()
