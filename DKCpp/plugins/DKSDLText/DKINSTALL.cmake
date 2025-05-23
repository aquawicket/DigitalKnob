#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSDLText ############
dk_depend(DKAssets)
dk_depend(DKSDLWindow)
dk_depend(sdl_ttf)

dk_generateCmake(DKSDLText)
dk_assets(DKSDLText)