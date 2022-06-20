include_guard()
dk_load(dk_color)

##################################################################################
# dk_assert(msg)
#
#	Print an assert message to the console and halts execution
#
#	@msg:(required) The message to print
#
macro(dk_assert msg)
	dk_call(dk_updateLogInfo)
	message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red}${msg}${CLR}")
	dk_call(dk_exit)
endmacro()
#macro(DKASSERT)
#	dk_assert(${ARGV})
#	#dk_call(dk_assert ${ARGV})
#endmacro()