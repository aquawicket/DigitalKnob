#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


###### ghost_toolbox ######
# https://github.com/ovsky/ghost-open-toolbox
# https://github.com/ovsky/ghost-open-toolbox/archive/b43ed1d2b3661eb1f76083330ba40e18bc9e36e8.zip

### INSTALL ###
dk_import()

dk_copy	("${ghost_toolbox}" "$ENV{SystemDrive}/Ghost Toolbox")
dk_exec("$ENV{SystemDrive}\\Ghost Toolbox\\ghost-commandline\\Ghost Toolbox 1.9.0.56.bat")