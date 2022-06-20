include_guard()
dk_load(dk_color)

##################################################################################
# dk_verbose(msg)
#
macro(dk_verbose)
	dk_call(dk_updateLogInfo)
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${magenta}${ARGV}${CLR}")
endmacro()
macro(DKVERBOSE)
	dk_verbose(${ARGV})
endmacro()