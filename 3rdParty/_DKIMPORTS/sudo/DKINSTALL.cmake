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


dk_validate(Target_Config  "dk_Target_Config()")
# https://www.sudo.ws

if(WIN32)
	return()
endif()

if(EXISTS ${sudo_exe})
	return()
endif()


dk_findProgram(sudo_exe sudo)
if(NOT EXISTS ${sudo_exe})
	dk_set(sudo_exe "")
	dk_unset(sudo_exe)
endif()



dk_set(sudo_exe ${sudo_exe})   # set it globally
message("sudo_exe = ${sudo_exe}")
