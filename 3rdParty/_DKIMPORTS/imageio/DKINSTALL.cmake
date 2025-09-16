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


############ imageio ###########
# https://developer.apple.com/documentation/imageio
dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT Mac_Host)
	dk_disable(imageio)
	dk_return()
endif()

find_library(ImageIO_lib ImageIO)
if(NOT ImageIO_lib)
	dk_warning("Could not locate ImageIO framework")
endif()
Apple_dk_lib(${ImageIO_lib})
