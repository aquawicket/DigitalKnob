#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/imageio

if(NOT MAC_HOST)
	dk_undepend(imageio)
	dk_return()
endif()


find_library(ImageIO_lib ImageIO)
if(NOT ImageIO_lib)
	dk_warning("Could not locate ImageIO framework")
endif()
APPLE_dk_lib(${ImageIO_lib})
