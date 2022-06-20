include_guard()
dk_load(dk_color)

##################################################################################
# dk_warn(msg)
#
macro(dk_warn)
	dk_call(dk_updateLogInfo)
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow}${ARGV}${CLR}")
endmacro()
macro(DKWARN)
	dk_warn(${ARGV})
endmacro()