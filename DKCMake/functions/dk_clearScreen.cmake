#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_clearScreen()
#
#	Clear the console
#
function(dk_clearScreen)
	dk_debugFunc()
	
	### Powershell ###
	find_program(POWERSHELL_EXE powershell.exe)
	if(POWERSHELL_EXE)
		execute_process(COMMAND powershell clear)
		return()
	endif()
	
	### Cmd ###
	dk_depend(cmd)
	if(CMD_EXE)
		execute_process(COMMAND ${CMD_EXE} /c clear)  # FIXME: only clears 1 line
		return()
	endif()
	
	### Bash ###
	dk_depend(bash)
	if(BASH_EXE)
		execute_process(COMMAND clear)
		return()
	endif()
	
	dk_fatal("no clear screen commands available")
	
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_clearScreen()
endfunction()
