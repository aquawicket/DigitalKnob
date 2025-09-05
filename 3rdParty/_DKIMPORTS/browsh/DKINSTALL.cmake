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
 
 
###### browsh ###### 
# https://github.com/browsh-org/browsh/releases/download/v1.8.0/browsh_1.8.0_windows_amd64.exe 
 
dk_import()

dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
dk_copy("${DKDOWNLOAD_DIR}/${browsh_Download_Basename}" "${browsh}/${browsh_Download_Basename}")