include_guard()

##################################################################################
# dk_debug(msg)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
function(dk_debug msg)
	#DKDEBUGFUNC(${ARGV})
	
	if(DKDEBUG_ENABLED)
		dk_printvar(msg)
		
		dk_updateLogInfo()
		message(DEBUG "${H_black}${STACK_HEADER}${CLR}${blue} ${msg} ${CLR}")
	endif()
endfunction()
