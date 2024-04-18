include_guard()

##################################################################################
# dk_trace(msg) PRINTVAR
#
#	Print the trace stack with a message to the console
#
#	@msg	- The message to print
#
function(dk_trace msg)
	#DKDEBUGFUNC(${ARGV})
	dk_get_option(PRINTVAR ${ARGV})
	dk_printvar(msg)
	
	dk_dumpAllVariables(${CMAKE_BINARY_DIR}/dk_trace_variables.temp)
	
	dk_updateLogInfo()
	message(TRACE "${H_black}${STACK_HEADER}${clr}${B_blue} ${msg} ${clr}")
endfunction()
