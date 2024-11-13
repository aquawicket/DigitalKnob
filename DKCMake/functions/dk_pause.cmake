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
	if(DEFINED ENV{BASH})
		execute_process(COMMAND $ENV{BASH} read -p)
		dk_return()
	elseif(EXISTS $ENV{BASH})
		execute_process(COMMAND $ENV{BASH} read -p)
		dk_return()
	elseif(EXISTS "/bin/bash")
		execute_process(COMMAND "/bin/bash" read -p)
		dk_return()
	elseif(DEFINED ENV{SHELL})
		execute_process(COMMAND $ENV{SHELL} read -p)
		dk_return()
	elseif(EXISTS $ENV{SHELL})
		execute_process(COMMAND $ENV{SHELL} read -p)
		dk_return()
	else()	
		execute_process(COMMAND sh read -p)
		dk_return()
	endif()
		
	dk_fatal("dk_pause() failed:   both CMD_EXE and BASH_EXE are invalid!")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_pause()
	dk_pause("Pause with a custom message")
	dk_pause("${red}Pause ${green}with ${blue}colorful ${yellow}message${clr}")
	dk_echo("pause with no message")
	dk_pause(" ")
endfunction()
