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


############ libasound2-dev ############

if(NOT Linux AND NOT Raspberry)
	dk_disable(libasound2-dev)
	dk_return()
endif()
if("$ENV{WSL_DISTRO_NAME}" STREQUAL "Alpine")
	dk_disable(libasound2-dev)
	dk_return()
endif()

### INSTALL ###
dk_installPackage(libasound2-dev)

### Tiny Core Linux ###
#if(TINYCORE)
#	dk_exec(tce-load -wi libasound2-dev)
#endif()

### LINK ###
dk_include(/usr/include/alsa)
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lasound")
