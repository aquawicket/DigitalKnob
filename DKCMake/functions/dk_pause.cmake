#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##############################################################################
# dk_pause(pause_msg)
# 
#	Pause execution and wait for keypress to continue
#
function(dk_pause) 
	dk_debugFunc("\${ARGV}")
#	message(${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE})


	###### ${pause_msg} ######
	if(ARGN)
		set(pause_msg "${ARGN}")
	else()
		set(pause_msg "Press and any to continue...")
	endif()
	dk_echo("${pause_msg}")
	
	###### Cmd ######
	dk_depend(cmd)
	#find_program(CMD_EXE cmd.exe)
	if(CMD_EXE)
		dk_replaceAll(${CMD_EXE} "/" "\\" CMD_EXE)   # convert to windows path delimiters
		execute_process(COMMAND ${CMD_EXE} /c pause >nul)
		return()
	endif()
	
	###### Powershell ######
	find_program(POWERSHELL_EXE powershell.exe)
	if(POWERSHELL_EXE)
		execute_process(COMMAND ${POWERSHELL_EXE} Read-Host)
		return()
	endif()
	
	###### Bash ######
	find_program(BASH_EXE bash)
	if(BASH_EXE)
		execute_process(COMMAND ${BASH_EXE} read -p)
		return()
	endif()
		
	dk_fatal("dk_pause() failed:   both CMD_EXE and BASH_EXE are invalid!")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_pause()
	dk_pause("Pause with a custom message")
	dk_pause("${red}Pause ${green}with ${blue}colorful ${yellow}message${clr}")
	dk_echo("pause with no message")
	dk_pause(" ")
endfunction()
