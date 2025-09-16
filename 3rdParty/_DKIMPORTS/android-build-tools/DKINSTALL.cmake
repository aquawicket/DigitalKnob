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


###### android-build-tools ######
dk_depend(android-sdk)

#dk_validate(Host_Os "dk_Host_Os()")
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_mkdir(${android-sdk}/build-tools)

if(Windows_Host)
	dk_import(${android-build-tools_Windows_Import} INSTALL_PATH "${android-sdk}/build-tools/${android-build-tools_Version}")
elseif(Mac_Host)
	dk_import(${android-build-tools_Mac_Import} 	INSTALL_PATH "${android-sdk}/build-tools/${android-build-tools_Version}")
else()
    dk_import(${android-build-tools_Linux_Import} 	INSTALL_PATH "${android-sdk}/build-tools/${android-build-tools_Version}")
endif()


