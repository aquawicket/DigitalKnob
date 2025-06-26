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
 
 
###### rufus ###### 
# https://github.com/pbatard/rufus/releases/download/v4.7/rufus-4.7p.exe 
 
### INSTALL ### 
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_validate(Host_Tuple "dk_Host_Tuple()")
set(RUFUS_IMPORT "${Rufus_${Host_Truple}_Import}")

dk_download		("${RUFUS_IMPORT}")
dk_validate		(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_mkdir		("$ENV{DKTOOLS_DIR}/rufus")
dk_validate		(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
dk_basename		("${RUFUS_IMPORT}")
dk_copy			("$ENV{DKDOWNLOAD_DIR}/${dk_basename}" "$ENV{DKTOOLS_DIR}/rufus/${dk_basename}")