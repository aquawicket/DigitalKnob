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


###### resourcehacker ######
# https://www.angusj.com/resourcehacker/resource_hacker.zip

### UnINSTALL ###
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_fileVariables	("${DKIMPORTS_DIR}/resourcehacker/dkconfig.txt")
dk_importVariables	(${resourcehacker_Import} NAME resourcehacker)
dk_delete			("${resourcehacker}")
