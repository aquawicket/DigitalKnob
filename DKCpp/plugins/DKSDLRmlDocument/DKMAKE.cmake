#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSDLRmlDocument ############
dk_depend(rmlui)
dk_depend(DKAssets)
dk_depend(DKCurl)
dk_depend(DKSDLWindow)
#dk_depend(DKRmlInterface)			//LINUX FIX:
dk_depend(sdl_image)

dk_generateCmake(DKSDLRmlDocument)