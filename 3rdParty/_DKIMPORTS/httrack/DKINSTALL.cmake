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
 
 
###### httrack ###### 
# https://download.httrack.com/httrack_x64-noinst-3.49.2.zip
 
### INSTALL ### 
dk_validate			(DKTOOLS_DIR "dk_DKTOOLS_DIR")
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
if(Windows_X86_Host)
	dk_import		(${httrack_Windows_X86_Import} ROOT ${DKTOOLS_DIR})
elseif(Windows_X86_64_Host)
	dk_import		(${httrack_Windows_X86_64_Import} ROOT ${DKTOOLS_DIR})
endif
