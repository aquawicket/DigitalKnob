include_guard()

##################################################################################
# dk_verbose(msg)
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
function(dk_verbose msg)
	#DKDEBUGFUNC(${ARGV})
	
	if(DKVERBOSE_ENABLED)
		dk_printvar(msg)
		
		dk_updateLogInfo()
		message(VERBOSE "${H_black}${STACK_HEADER}${CLR}${cyan} ${msg} ${CLR}")
	endif()
endfunction()
