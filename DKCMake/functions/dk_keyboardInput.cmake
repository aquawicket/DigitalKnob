include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##############################################################################
# dk_keyboardInput(variable)
# 
#
function(dk_keyboardInput input) 
	dk_debugFunc(${ARGV})

	find_program(CMD_EXE cmd.exe)
	if(CMD_EXE)
		#	@echo off
		#	set /p "input="
		#	echo %input%
		dk_fileWrite($ENV{TMP}/keyboardInput.cmd "@echo off & set /p \"input=\"\necho %input%")
		execute_process(COMMAND cmd /c $ENV{TMP}/keyboardInput.cmd OUTPUT_VARIABLE output OUTPUT_STRIP_TRAILING_WHITESPACE)
		dk_delete(keyboardInput.cmd)
		if("${output}" STREQUAL "ECHO is off.")
			set(output "")
		endif()
		set(${input} ${output} PARENT_SCOPE)
		return()
	endif()
	
	find_program(BASH_EXE bash)
	if(BASH_EXE)
		dk_validate(DKBASH_DIR "dk_getDKPaths()")
		#execute_process(COMMAND bash -c 'source ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh; dk_pause')
		execute_process(COMMAND ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh & dk_pause)
		return()
	endif()
		
	dk_error("dk_pause() failed:   both CMD_EXE and BASH_EXE are invalid!")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_keyboardInput(input)
	dk_echo("you typed '${input}'")
endfunction()
