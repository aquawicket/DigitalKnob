include_guard()

##################################################################################
# dk_notice(msg) PRINTVAR
#
#	Print a NOTICE message
#
#	@msg	- The message to print
#
function(dk_notice msg)
	#dk_debugFunc(${ARGV})
	
	dk_getOption(PRINTVAR ${ARGV})
	dk_printVar(msg)
	
	dk_updateLogInfo()
	#message(NOTICE "${H_black}${STACK_HEADER}${clr}${B_yellow} ${msg} ${clr}")
	message(NOTICE "${B_yellow}${msg}${clr}")
endfunction()
