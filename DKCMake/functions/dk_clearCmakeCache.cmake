#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_clearCmakeCache()
#
#
function(dk_clearCmakeCache)
	dk_debugFunc("\${ARGV}")

    dk_info("Deleting CMake cache files. . .")
	
	execute_process(COMMAND cmd /c for /r %i in (CMakeCache.*) do del "%i" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
    execute_process(COMMAND cmd /c for /d /r %i in (*CMakeFiles*) do rd /s /q "%i" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
endfunction()













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_clearCmakeCache()
endfunction()
