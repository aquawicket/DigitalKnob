#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


########### ida ############
# https://hex-rays.com/ida-free/
# https://out7.hex-rays.com/files/idafree84_windows.exe

dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_import(https://out7.hex-rays.com/files/idafree84_windows.exe ROOT ${DKTOOLS_DIR})
