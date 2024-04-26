include_guard()

###############################################################################
# dk_clearScreen()
#
#	Clear the console
#
function(dk_clearScreen)
	#dk_debugFunc(${ARGV})
	
	dk_debug("clear screen")
	
	find_program(CMD_EXE cmd.exe)
	dk_debug(CMD_EXE)
	find_program(BASH_EXE bash)
	dk_debug(BASH_EXE)

	if(CMD_EXE)
		dk_debug("execute_process(COMMAND cmd /c cls)")
		#dk_executeProcess(cls)
		execute_process(COMMAND cmd /c cls)
	elseif(BASH_EXE)
		dk_debug("execute_process(COMMAND clear)")
		execute_process(COMMAND clear)
	else()
		dk_error("no clear screen commands available")
	endif()
	
endfunction()