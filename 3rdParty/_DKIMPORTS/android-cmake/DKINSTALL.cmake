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


###### android-cmake ######
dk_validate(android-sdk "dk_depend(android-sdk)")

if(Windows_Host)
	dk_import	(${android-cmake_Windows_Import} 	INSTALL_PATH ${android-sdk}/cmake)
elseif(Mac_Host)
	dk_import	(${android-cmake_Mac_Import} 		INSTALL_PATH ${android-sdk}/cmake)
else()
	dk_import	(${android-cmake_Linux_Import} 		INSTALL_PATH ${android-sdk}/cmake)
endif()


