#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ windows-sdk ############
# https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/

dk_import(https://go.microsoft.com/fwlink/?linkid=2272523)   # iso
#dk_import(https://go.microsoft.com/fwlink/?linkid=2272610)  # installer