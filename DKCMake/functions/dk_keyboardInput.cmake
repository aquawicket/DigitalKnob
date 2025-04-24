#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##############################################################################
# dk_keyboardInput(variable)
# 
#
function(dk_keyboardInput input) 
	dk_debugFunc()

	dk_depend(cmd)
	#find_program(CMD_EXE cmd.exe)
	if(CMD_EXE)
		#	@echo off
		#	set /p "input="
		#	echo %input%
		dk_fileWrite(${DKCACHE_DIR}/keyboardInput.cmd "@echo off & set /p \"input=\"\necho %input%")
		execute_process(COMMAND cmd /c ${DKCACHE_DIR}/keyboardInput.cmd OUTPUT_VARIABLE output OUTPUT_STRIP_TRAILING_WHITESPACE)
		dk_delete(${DKCACHE_DIR}/keyboardInput.cmd)
		if("${output}" STREQUAL "ECHO is off.")
			set(output "")
		endif()
		set(${input} ${output} PARENT_SCOPE)
		return()
	endif()
	
	dk_depend(bash)
	#find_program(BASH_EXE bash)
	if(BASH_EXE)
		dk_validate(DKBASH_DIR "dk_DKBASH_DIR()")
		#execute_process(COMMAND ${BASH_EXE} -c 'source ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh; dk_pause')
		execute_process(COMMAND ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh & dk_pause)
		return()
	endif()
		
	dk_fatal("dk_pause() failed:   both CMD_EXE and BASH_EXE are invalid!")
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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
	
	dk_fatal("Could not locate bash, sh, powershell or cmd")
>>>>>>> Development
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
=======
	dk_debugFunc(0)
	
	dk_echo("Testing dk_keyboardInput.cmake")
>>>>>>> Development
	dk_keyboardInput(input)
	dk_echo("you typed '${input}'")
endfunction()
