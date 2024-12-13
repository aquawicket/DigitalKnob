#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##############################################################################
# dk_keyboardInput(RETURN_VAR)
# 
#
function(dk_keyboardInput)
	dk_debugFunc(1)
	
	###### BASH ######
	execute_process(COMMAND bash -c "command -v 'bash'" OUTPUT_VARIABLE BASH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(EXISTS "${BASH_EXE}")
		set(cmnd ${BASH_EXE} -c "read -p '' stdin&& echo $stdin")
		#message("${cmnd}")
		execute_process(COMMAND ${cmnd} OUTPUT_VARIABLE stdin OUTPUT_STRIP_TRAILING_WHITESPACE)
		if("${stdin}" STREQUAL "$stdin")
			set(stdin "")
		endif()
		set(${ARGV0} "${stdin}" PARENT_SCOPE)
		return()
	endif()
	
	
	###### SH ######
	execute_process(COMMAND sh -c "command -v 'sh'" OUTPUT_VARIABLE SH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)	
	if(EXISTS "${SH_EXE}")
		set(cmnd ${SH_EXE} -c "read -p '' stdin&& echo $stdin")
		#message("${cmnd}")
		execute_process(COMMAND ${cmnd} OUTPUT_VARIABLE stdin OUTPUT_STRIP_TRAILING_WHITESPACE)
		if("${stdin}" STREQUAL "$stdin")
			set(stdin "")
		endif()
		set(${ARGV0} "${stdin}" PARENT_SCOPE)
		return()
	endif()
	
	
	###### POWERSHELL ######
	find_program(POWERSHELL_EXE powershell.exe)
	if(EXISTS "${POWERSHELL_EXE}")
		set(cmnd ${POWERSHELL_EXE} Read-Host)
		#message("${cmnd}")
		execute_process(COMMAND ${cmnd} OUTPUT_VARIABLE stdin OUTPUT_STRIP_TRAILING_WHITESPACE)
		if("${stdin}" STREQUAL "$stdin")
			set(stdin "")
		endif()
		set(${ARGV0} "${stdin}" PARENT_SCOPE)		
		return()
	endif()
	
	
	###### CMD ######
	if(EXISTS "$ENV{COMSPEC}")
		string(REPLACE "/" "\\" CMD_EXE "$ENV{COMSPEC}")  # convert to windows path delimiters
		set(cmnd "${CMD_EXE}" /V:ON /c "set /p stdin=& echo !stdin!")
		#message("${cmnd}")
		execute_process(COMMAND ${cmnd} OUTPUT_VARIABLE stdin OUTPUT_STRIP_TRAILING_WHITESPACE)		
		if("${stdin}" STREQUAL "!stdin!")
			set(stdin "")
		endif()
		set(${ARGV0} "${stdin}" PARENT_SCOPE)
		return()
	endif()
	
	dk_fatal("Could not locate cmd.exe or bash.exe")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo("Testing dk_keyboardInput.cmake")
	dk_keyboardInput(input)
	dk_echo("you typed '${input}'")
endfunction()
