#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##############################################################################
# dk_keyboardInput(rtn_var)
# 
#
function(dk_keyboardInput) 
	dk_debugFunc(1)
	
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
	
	### keyboard input VIA bash ###
	dk_validate(BASH_EXE "dk_BASH_EXE()")
	if(BASH_EXE)
		dk_validate(DKBASH_DIR "dk_DKBASH_DIR()")
		#execute_process(COMMAND ${BASH_EXE} -c 'source ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh; dk_pause')
		execute_process(COMMAND ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh & dk_pause)
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
