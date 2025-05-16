#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ imageio ###########
# https://developer.apple.com/documentation/imageio
dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT Mac_Host)
	dk_undepend(imageio)
	dk_return()
endif()

find_library(ImageIO_lib ImageIO)
if(NOT ImageIO_lib)
	dk_warning("Could not locate ImageIO framework")
endif()
APPLE_dk_lib(${ImageIO_lib})
