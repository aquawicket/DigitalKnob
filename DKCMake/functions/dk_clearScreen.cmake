#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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
