include_guard()

##################################################################################
# dk_echo(msg)
#
#	Print a message to the console
#
#	@msg	- The message to print
#
macro(dk_echo msg)
	#dk_debugFunc(${ARGV})
	
	#dk_printVar(msg)
	message("${msg}")
endmacro()
