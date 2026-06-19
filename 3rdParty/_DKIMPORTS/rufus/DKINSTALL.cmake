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
 
 
###### rufus ###### 
# https://github.com/pbatard/rufus/releases/download/v4.7/rufus-4.7p.exe 
 
dk_download		("${rufus_Import}")
dk_validate		(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_mkdir		("${DKTOOLS_DIR}/rufus")
dk_validate		(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
dk_basename		("${rufus_Import}")
dk_copy			("${dk_download}" "${DKTOOLS_DIR}/rufus/${dk_basename}")
