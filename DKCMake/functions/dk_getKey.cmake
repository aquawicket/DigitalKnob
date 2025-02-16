#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_getKey(rtn_var)
#
#
function(dk_getKey rtn_var)
	dk_debugFunc(1)

	dk_depend(cmd)
	if(CMD_EXE)
		dk_fixme("${CMAKE_CURRENT_FUNCTION}")
		execute_process(COMMAND ${CMD_EXE} /c pause)
		return()
	endif()
	
	dk_depend(bash)
	if(BASH_EXE)
		dk_fixme("${CMAKE_CURRENT_FUNCTION}")
		execute_process(COMMAND ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh & dk_pause)
		return()
	endif()
		
	dk_fatal("dk_getKey() failed:   both CMD_EXE and BASH_EXE are invalid!")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_getKey(result)
	dk_info("result = ${result}")
endfunction()