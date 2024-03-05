include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


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
	
	dk_updateLogInfo()
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${B_blue} ${msg} ${CLR}")
endfunction()
