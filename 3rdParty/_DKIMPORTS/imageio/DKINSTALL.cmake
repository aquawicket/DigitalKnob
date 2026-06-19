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


############ imageio ###########
# https://developer.apple.com/documentation/imageio

if(NOT Mac_Host)
	dk_disable(imageio)
	dk_return()
endif()

find_library(ImageIO_lib ImageIO)
if(NOT ImageIO_lib)
	dk_warning("Could not locate ImageIO framework")
endif()
Apple_dk_lib(${ImageIO_lib})
