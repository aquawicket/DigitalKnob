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


###### useful_bat_files ######
# https://github.com/scottgriv/batch-useful_bat_files/archive/refs/heads/main.zip

### INSTALL ###
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import		(${USEFUL_BAT_FILES_IMPORT} NAME useful_bat_files)
