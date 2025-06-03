#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


dk_validate(Config_Path  "dk_Config_Path()")
# https://www.sudo.ws

if(WIN32)
	return()
endif()

if(EXISTS ${SUDO_EXE})
	return()
endif()


dk_findProgram(SUDO_EXE sudo)
if(NOT EXISTS ${SUDO_EXE})
	dk_set(SUDO_EXE "")
	dk_unset(SUDO_EXE)
endif()



dk_set(SUDO_EXE ${SUDO_EXE})   # set it globally
message("SUDO_EXE = ${SUDO_EXE}")
