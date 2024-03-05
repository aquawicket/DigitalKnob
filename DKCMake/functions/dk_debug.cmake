include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


##################################################################################
# dk_debug(msg) PRINTVAR
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
function(dk_debug msg)
	#DKDEBUGFUNC(${ARGV})
	if(DKDEBUG_ENABLED)
		dk_get_option(PRINTVAR ${ARGV})
		dk_printvar(msg)
		
		dk_updateLogInfo()
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${cyan} ${msg} ${CLR}")
	endif()
endfunction()