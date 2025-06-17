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


###### 7z ######
# https://www.7-zip.org/a/7z2409-extra.7z
#

### INSTALL ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import			(${7z_Import})
dk_assertVar		(7Z)
dk_set				(7ZA_EXE	"${7Z}/7za.exe")
dk_assertPath		(7ZA_EXE)
