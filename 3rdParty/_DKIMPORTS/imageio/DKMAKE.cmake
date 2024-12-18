#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ imageio ###########
# https://developer.apple.com/documentation/imageio
dk_load(dk_builder)
if(NOT MAC_HOST)
	dk_undepend(imageio)
	dk_return()
endif()

find_library(ImageIO_lib ImageIO)
if(NOT ImageIO_lib)
	dk_warning("Could not locate ImageIO framework")
endif()
APPLE_dk_lib(${ImageIO_lib})
