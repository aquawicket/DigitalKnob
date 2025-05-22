#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_title(string)
#
#
function(dk_title)
    dk_debugFunc(0 99)
 
	dk_depend(cmd)
	if(EXISTS "${CMD_EXE}")
		dk_replaceAll("${CMD_EXE}" "/" "\\" CMD_EXE)
		execute_process(COMMAND ${CMD_EXE} /c "title ${ARGV}")
	endif()
endfunction()











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)

    dk_title("............testing dk_title.......................")
endfunction()
