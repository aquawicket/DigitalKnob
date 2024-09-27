#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getKey(rtn_var)
#
#
function(dk_getKey rtn_var)
	dk_debugFunc("\${ARGV}")
	if(NOT ${ARGC} EQUAL 0)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()

	dk_depend(cmd)
	#find_program(CMD_EXE cmd.exe)
	if(CMD_EXE)
		dk_fixme("${CMAKE_CURRENT_FUNCTION}")
		execute_process(COMMAND cmd /c pause)
		return()
	endif()
	
	find_program(BASH_EXE bash)
	if(BASH_EXE)
		dk_fixme("${CMAKE_CURRENT_FUNCTION}")
		execute_process(COMMAND ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh & dk_pause)
		return()
	endif()
		
	dk_fatal("dk_getKey() failed:   both CMD_EXE and BASH_EXE are invalid!")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_getKey(result)
	dk_info("result = ${result}")
endfunction()