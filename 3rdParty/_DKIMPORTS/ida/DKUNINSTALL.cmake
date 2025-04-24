#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


########### ida ############
# https://hex-rays.com/ida-free/
# https://out7.hex-rays.com/files/idafree84_windows.exe


if(EXISTS "$ENV{DKTOOLS_DIR}/Ida/uninstall.exe")
	dk_validate		(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
	execute_process	(COMMAND "$ENV{DKTOOLS_DIR}/Ida/uninstall.exe" --mode unattended)
endif()
