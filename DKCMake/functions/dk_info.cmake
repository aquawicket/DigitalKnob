include_guard()

##################################################################################
# dk_info(msg)
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
function(dk_info msg)
	#DKDEBUGFUNC(${ARGV})
	
	dk_printvar(msg)
	
	dk_updateLogInfo()
	message("${H_black}${STACK_HEADER}${CLR}${white} ${msg} ${CLR}")
endfunction()
