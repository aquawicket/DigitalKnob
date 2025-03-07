#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ imageio ###########
# https://developer.apple.com/documentation/imageio
dk_validate(host_triple "dk_host_triple()")
if(NOT MAC_HOST)
	dk_undepend(imageio)
	dk_return()
endif()

find_library(ImageIO_lib ImageIO)
if(NOT ImageIO_lib)
	dk_warning("Could not locate ImageIO framework")
endif()
APPLE_dk_lib(${ImageIO_lib})
