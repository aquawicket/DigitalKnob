include_guard()

##################################################################################
# dk_echo(msg)
#
#	Print a message to the console
#
#	@msg	- The message to print
#
macro(dk_echo msg)
	#DKDEBUGFUNC(${ARGV})
	
	dk_printvar(msg)
	message("${msg}")
endmacro()
