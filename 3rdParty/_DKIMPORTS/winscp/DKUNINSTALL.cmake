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


###### winscp ######
# https://cdn.winscp.net/files/WinSCP-6.5.1-Portable.zip?secure=UvesZYGRF7C1SSAvJGMyeg==,1759977056

dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_importVariables	(${winscp_Import} NAME winscp)
dk_delete			("${winscp}")
