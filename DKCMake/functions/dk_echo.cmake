include_guard()

##################################################################################
# dk_echo(msg)
#
#	Print a message to the console
#
#	@msg	- The message to print
#
function(dk_echo msg)
	#dk_debugFunc(${ARGV})
	
	message("${msg}")
endfunction()
