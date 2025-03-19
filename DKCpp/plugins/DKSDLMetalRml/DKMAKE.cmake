#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSDLMetalRml ############

if(NOT USE_metal)
	dk_return()
endif()

dk_depend(DKAssets)
dk_depend(DKSDLMetalWindow)
dk_depend(DKRml)
dk_depend(sdl_image)
## dk_depend(sdl2_gif) ##Deprecated
## dk_depend(sdl2_giflib_sa-master) ##FIXME

dk_generateCmake(DKSDLMetalRml)