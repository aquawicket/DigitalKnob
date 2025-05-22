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
		set(pause_msg "Press Enter to continue...")
	endif()
	dk_echo("${pause_msg}")
	
	###### Cmd ######
	if(DEFINED ENV{COMSPEC})
		dk_replaceAll($ENV{COMSPEC} "/" "\\" CMD_EXE)   # convert to windows path delimiters
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
		dk_return()
	endif()
	
	###### Powershell ######
	find_program(POWERSHELL_EXE powershell.exe)
	if(POWERSHELL_EXE)
		set(cmnd ${POWERSHELL_EXE} Read-Host)
		dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})
		dk_return()
	endif()
	
	dk_fatal("dk_pause() failed:  cant find CMD_EXE, BASH_EXE or SH_EXE!")
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
