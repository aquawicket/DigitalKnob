#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##############################################################################
# dk_keyboardInput(rtn_var)
# 
#
function(dk_keyboardInput) 
	dk_debugFunc(1)
	
	###### BASH ######
	execute_process(COMMAND bash -c "command -v 'bash'" OUTPUT_VARIABLE BASH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(BASH_EXE)
		set(cmnd ${BASH_EXE} -c "read -p '' stdin&& echo $stdin")
		#message("${cmnd}")
		execute_process(COMMAND ${cmnd} OUTPUT_VARIABLE stdin OUTPUT_STRIP_TRAILING_WHITESPACE)
		if("${stdin}" STREQUAL "$stdin")
			set(stdin "")
		endif()
		set(${ARGV0} "${stdin}" PARENT_SCOPE)
		dk_return()
	endif()
	
	
	###### SH ######
	execute_process(COMMAND sh -c "command -v 'sh'" OUTPUT_VARIABLE SH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(SH_EXE)
		set(cmnd ${SH_EXE} -c "read -p '' stdin&& echo $stdin")
		#message("${cmnd}")
		execute_process(COMMAND ${cmnd} OUTPUT_VARIABLE stdin OUTPUT_STRIP_TRAILING_WHITESPACE)
		if("${stdin}" STREQUAL "$stdin")
			set(stdin "")
		endif()
		set(${ARGV0} "${stdin}" PARENT_SCOPE)
		dk_return()
	endif()
	
	
	### keyboard input VIA cmd.exe ###
	dk_validate(CMD_EXE "dk_CMD_EXE()")
	if(EXISTS ${CMD_EXE})
		dk_replaceAll("${CMD_EXE}" "/" "\\" CMD_EXE)
		set(command "${CMD_EXE}" /V:ON /c "set /p stdin=& echo !stdin!")
		#message("command = ${command}")
		execute_process(COMMAND ${command} OUTPUT_VARIABLE stdin OUTPUT_STRIP_TRAILING_WHITESPACE)		
		if("${stdin}" STREQUAL "!stdin!")
			set(stdin "")
		endif()
		set(${ARGV0} "${stdin}" PARENT_SCOPE)
		dk_return()
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
