#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##############################################################################
# dk_pause(pause_msg)
# 
#	Pause execution and wait for keypress to continue
#
function(dk_pause) 
	dk_debugFunc()
<<<<<<< HEAD

=======
	
>>>>>>> Development
	###### ${pause_msg} ######
	if(ARGN)
		set(pause_msg "${ARGN}")
	else()
<<<<<<< HEAD
		set(pause_msg "Press any key to continue...")
=======
		set(pause_msg "Press Enter to continue...")
>>>>>>> Development
	endif()
	dk_echo("${pause_msg}")
	
	###### Cmd ######
	if(DEFINED ENV{COMSPEC})
		dk_replaceAll($ENV{COMSPEC} "/" "\\" CMD_EXE)   # convert to windows path delimiters
<<<<<<< HEAD
		execute_process(COMMAND ${CMD_EXE} /c pause >nul)
=======
		set(cmnd ${CMD_EXE} /c pause >nul)
		dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})
		dk_return()
	endif()
	
	###### BASH ######
	execute_process(COMMAND bash -c "command -v 'bash'" OUTPUT_VARIABLE BASH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(BASH_EXE)
		set(cmnd ${BASH_EXE} -c "read -p ''")
		dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})
		dk_return()
	endif()
	
	###### SH ######
	execute_process(COMMAND sh -c "command -v 'sh'" OUTPUT_VARIABLE SH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(SH_EXE)			
		set(cmnd ${SH_EXE} -c "read -p ''")
		dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})
>>>>>>> Development
		dk_return()
	endif()
	
	###### Powershell ######
	find_program(POWERSHELL_EXE powershell.exe)
	if(POWERSHELL_EXE)
<<<<<<< HEAD
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
=======
		set(cmnd ${POWERSHELL_EXE} Read-Host)
		dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})
		dk_return()
	endif()
	
	dk_fatal("dk_pause() failed:  cant find CMD_EXE, BASH_EXE or SH_EXE!")
>>>>>>> Development
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_pause()
	dk_pause("Pause with a custom message")
	dk_pause("${red}Pause ${green}with ${blue}colorful ${yellow}message${clr}")
	dk_echo("pause with no message")
	dk_pause(" ")
endfunction()
