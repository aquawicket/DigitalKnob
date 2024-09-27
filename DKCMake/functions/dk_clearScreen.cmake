#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_clearScreen()
#
#	Clear the console
#
function(dk_clearScreen)
	dk_debugFunc("\${ARGV}")
	
	### Powershell ###
	find_program(POWERSHELL_EXE powershell.exe)
	if(POWERSHELL_EXE)
		execute_process(COMMAND powershell clear)
		return()
	endif()
	
	### Cmd ###
	#find_program(CMD_EXE cmd.exe)
	dk_depend(cmd)
	if(CMD_EXE)
		execute_process(COMMAND cmd /c clear)  # FIXME: only clears 1 line
		return()
	endif()
	
	### Bash ###
	find_program(BASH_EXE bash)
	if(BASH_EXE)
		execute_process(COMMAND clear)
		return()
	endif()
	
	dk_fatal("no clear screen commands available")
	
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_clearScreen()
endfunction()
