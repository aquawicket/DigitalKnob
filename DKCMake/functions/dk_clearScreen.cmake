include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_clearScreen()
#
#	Clear the console
#
function(dk_clearScreen)
	dk_debugFunc(${ARGV})
	
	
	find_program(CMD_EXE cmd.exe)
	dk_printVar(CMD_EXE)
	find_program(BASH_EXE bash)
	dk_printVar(BASH_EXE)

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






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)