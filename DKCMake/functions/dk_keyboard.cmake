#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_keyboard(rtn_var)
#
#
function(dk_keyboard)
	dk_debugFunc()
	if(NOT ${ARGC} EQUAL 0)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()

	dk_depend(cmd)
	#find_program(CMD_EXE cmd.exe)
	if(CMD_EXE)
		dk_validate(DKBATCH_FUNCTIONS_DIR "dk_DKBRANCH_DIR()")
		dk_cd(${DKBATCH_FUNCTIONS_DIR})
		execute_process(COMMAND cmd /c ${DKBATCH_FUNCTIONS_DIR}/dk_keyboard.cmd OUTPUT_VARIABLE rtn_var ECHO_OUTPUT_VARIABLE)
		dk_info("rtn_var = ${rtn_var}")
		return()
	endif()
	
	dk_depend(bash)
	#find_program(BASH_EXE bash)
	if(BASH_EXE)
		dk_validate(DKBASH_FUNCTIONS_DIR "dk_DKBRANCH_DIR()")
		execute_process(COMMAND ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh & dk_pause)
		return()
	endif()
		
	dk_fatal("dk_getKey() failed:   both CMD_EXE and BASH_EXE are invalid!")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_keyboard()
endfunction()