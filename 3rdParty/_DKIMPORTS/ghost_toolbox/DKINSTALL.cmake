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


###### ghost_toolbox ######
# https://github.com/ovsky/ghost-open-toolbox

### INSTALL ###
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import		("${ghost_toolbox_Import}")

dk_copy	("${DK3RDPARTY_DIR}/ghost_toolbox-b43ed1d2b3661eb1f76083330ba40e18bc9e36e8" "$ENV{SystemDrive}/Ghost Toolbox")
execute_process(COMMAND "$ENV{SystemDrive}\\Ghost Toolbox\\ghost-commandline\\Ghost Toolbox 1.9.0.56.bat")