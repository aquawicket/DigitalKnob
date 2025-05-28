#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSDLRml ############
dk_depend(DKAssets)
dk_depend(DKSDLWindow)
dk_depend(DKRml)
dk_depend(sdl_image)
## dk_depend(sdl2_gif) ##Deprecated
## dk_depend(sdl2_giflib_sa-master) ##FIXME





############ DKSDLRml ############
dk_set(CURRENT_PLUGIN "DKSDLRml")
dk_generateCmake(DKSDLRml)
dk_assets(DKSDLRml)
dk_set(DKSDLRml "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKSDLRml")
dk_configure(${DKSDLRml})
dk_build(${DKSDLRml})