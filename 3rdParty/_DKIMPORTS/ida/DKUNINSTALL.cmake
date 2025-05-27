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


########### ida ############
# https://hex-rays.com/ida-free/
# https://out7.hex-rays.com/files/idafree84_windows.exe


if(EXISTS "$ENV{DKTOOLS_DIR}/Ida/uninstall.exe")
	dk_validate		(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
	execute_process	(COMMAND "$ENV{DKTOOLS_DIR}/Ida/uninstall.exe" --mode unattended)
endif()
