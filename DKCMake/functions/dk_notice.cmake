include_guard()

##################################################################################
# dk_notice(msg) PRINTVAR
#
#	Print a NOTICE message
#
#	@msg	- The message to print
#
function(dk_notice msg)
	#DKDEBUGFUNC(${ARGV})
	
	dk_get_option(PRINTVAR ${ARGV})
	dk_printvar(msg)
	
	dk_updateLogInfo()
	message(NOTICE "${H_black}${STACK_HEADER}${CLR}${B_yellow} ${msg} ${CLR}")
endfunction()
