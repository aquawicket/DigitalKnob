#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##############################################################################
# dk_pause(pause_msg)
# 
#	Pause execution and wait for keypress to continue
#
function(dk_pause) 
	dk_debugFunc()

	###### ${pause_msg} ######
	if(ARGN)
		set(pause_msg "${ARGN}")
	else()
		set(pause_msg "Press any key to continue...")
	endif()
	dk_echo("${pause_msg}")
	
	###### Cmd ######
	#dk_depend(cmd)
	if(DEFINED ENV{COMSPEC})
		dk_replaceAll($ENV{COMSPEC} "/" "\\" CMD_EXE)   # convert to windows path delimiters
		execute_process(COMMAND ${CMD_EXE} /c pause >nul)
		dk_return()
	endif()
	
	###### Powershell ######
	find_program(POWERSHELL_EXE powershell.exe)
	if(POWERSHELL_EXE)
		execute_process(COMMAND ${POWERSHELL_EXE} Read-Host)
		dk_return()
	endif()
	
	###### Bash ######
	dk_depend(bash)
	#find_program(BASH_EXE bash)
	if(BASH_EXE)
		execute_process(COMMAND ${BASH_EXE} read -p)
		dk_return()
	endif()
		
	dk_fatal("dk_pause() failed:   both CMD_EXE and BASH_EXE are invalid!")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_pause()
	dk_pause("Pause with a custom message")
	dk_pause("${red}Pause ${green}with ${blue}colorful ${yellow}message${clr}")
	dk_echo("pause with no message")
	dk_pause(" ")
endfunction()
