#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ freefilesync ############
# https://freefilesync.org

dk_import("https://freefilesync.org/download/FreeFileSync_13.7_Windows_Setup.exe")
