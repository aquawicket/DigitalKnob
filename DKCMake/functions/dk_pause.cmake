#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
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
	if(DEFINED ENV{ComSpec})
		dk_replaceAll($ENV{ComSpec} "/" "\\" ComSpec)   # convert to windows path delimiters
		set(cmnd ${ComSpec} /c pause >nul)
		#dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})
		dk_return()
	endif()
	
	###### BASH ######
	execute_process(COMMAND bash -c "command -v 'bash'" OUTPUT_VARIABLE bash_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(bash_exe)
		set(cmnd ${bash_exe} -c "read -p ''")
		#dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})
		dk_return()
	endif()
	
	###### SH ######
	execute_process(COMMAND sh -c "command -v 'sh'" OUTPUT_VARIABLE sh_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(sh_exe)			
		set(cmnd ${sh_exe} -c "read -p ''")
		#dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})
		dk_return()
	endif()
	
	###### Powershell ######
	find_program(powershell_exe powershell.exe)
	if(powershell_exe)
		set(cmnd ${powershell_exe} Read-Host)
		#dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})
		dk_return()
	endif()
	
	dk_fatal("dk_pause() failed:  cant find cmd.exe, bash_exe or sh_exe!")
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
