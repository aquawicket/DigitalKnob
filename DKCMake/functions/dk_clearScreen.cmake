include_guard()

###############################################################################
# dk_clearScreen()
#
#	Clear the console
#
function(dk_clearScreen)
	DKDEBUGFUNC(${ARGV})
	dk_debug("clear screen")
	execute_process(COMMAND "cmd /c cls")
endfunction()