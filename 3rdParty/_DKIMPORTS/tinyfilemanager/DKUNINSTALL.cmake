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


############ tinyfilemanager ############
# https://github.com/prasathmani/tinyfilemanager/archive/dd2e22781badf48b041643c5b2e428dd7965405f.zip

### UnINSTALL ###
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_fileVariables	("${DKIMPORTS_DIR}/tinyfilemanager/dkconfig.txt")
dk_importVariables	(${tinyfilemanager_Import} NAME tinyfilemanager)
dk_delete			("${tinyfilemanager}")
