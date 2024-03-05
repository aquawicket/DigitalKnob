include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


##################################################################################
# dk_verbose(msg) PRINTVAR
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
function(dk_verbose msg)
	#DKDEBUGFUNC(${ARGV})
	if(DKVERBOSE_ENABLED)
		dk_get_option(PRINTVAR ${ARGV})
		dk_printvar(msg)
		
		dk_updateLogInfo()
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${blue} ${msg} ${CLR}")
	endif()
endfunction()
