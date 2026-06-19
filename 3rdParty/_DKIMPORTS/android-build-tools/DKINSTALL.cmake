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


###### android-build-tools ######
dk_validate(android-sdk "dk_depend(android-sdk)")
#dk_mkdir(${android-sdk}/build-tools)

if(Windows_Host)
	dk_import(${android-build-tools_Windows_Import} INSTALL_PATH "${android-sdk}/build-tools/${android-build-tools_Version}")
elseif(Mac_Host)
	dk_import(${android-build-tools_Mac_Import} 	INSTALL_PATH "${android-sdk}/build-tools/${android-build-tools_Version}")
else()
    dk_import(${android-build-tools_Linux_Import} 	INSTALL_PATH "${android-sdk}/build-tools/${android-build-tools_Version}")
endif()


