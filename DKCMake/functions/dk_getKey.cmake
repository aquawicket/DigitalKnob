#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_getKey(rtn_var)
#
#
function(dk_getKey rtn_var)
<<<<<<< HEAD
	dk_debugFunc()
	if(NOT ${ARGC} EQUAL 0)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()

	dk_depend(cmd)
	#find_program(CMD_EXE cmd.exe)
	if(CMD_EXE)
		dk_fixme("${CMAKE_CURRENT_FUNCTION}")
		execute_process(COMMAND cmd /c pause)
=======
	dk_debugFunc(1)

	dk_depend(cmd)
	if(CMD_EXE)
		dk_fixme("${CMAKE_CURRENT_FUNCTION}")
		execute_process(COMMAND ${CMD_EXE} /c pause)
>>>>>>> Development
		return()
	endif()
	
	dk_depend(bash)
<<<<<<< HEAD
	#find_program(BASH_EXE bash)
=======
>>>>>>> Development
	if(BASH_EXE)
		dk_fixme("${CMAKE_CURRENT_FUNCTION}")
		execute_process(COMMAND ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh & dk_pause)
		return()
	endif()
		
	dk_fatal("dk_getKey() failed:   both CMD_EXE and BASH_EXE are invalid!")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_getKey(result)
	dk_info("result = ${result}")
endfunction()