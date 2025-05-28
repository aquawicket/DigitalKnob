#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
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




############ DKSDLMetalRml ############
dk_set(CURRENT_PLUGIN "DKSDLMetalRml")
dk_generateCmake(${CURRENT_PLUGIN})
dk_assets(${CURRENT_PLUGIN})
dk_set(${CURRENT_PLUGIN} "${CMAKE_CURRENT_LIST_DIR}")
dk_configure(${${CURRENT_PLUGIN}})
dk_build(${${CURRENT_PLUGIN}})