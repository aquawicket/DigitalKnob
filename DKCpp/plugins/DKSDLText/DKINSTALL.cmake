#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSDLText ############
dk_depend(DKAssets)
dk_depend(DKSDLWindow)
dk_depend(sdl_ttf)





############ DKSDLText ############
dk_set(CURRENT_PLUGIN "DKSDLText")
dk_generateCmake(DKSDLText)
dk_assets(DKSDLText)
dk_set(DKSDLText "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKSDLText")
dk_configure(${DKSDLText})
dk_build(${DKSDLText})
