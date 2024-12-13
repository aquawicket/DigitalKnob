#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_title(string)
#
#
function(dk_title)
    dk_debugFunc(0 99)
 
	dk_depend(cmd)
	if(EXISTS "${CMD_EXE}")
		dk_replaceAll("${CMD_EXE}" "/" "\\" CMD_EXE)
		execute_process(COMMAND ${CMD_EXE} /c title ${ARGV})
	endif()
endfunction()











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)

    dk_title(............testing dk_title.......................)
endfunction()
