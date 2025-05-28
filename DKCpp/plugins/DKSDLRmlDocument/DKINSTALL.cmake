#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSDLRmlDocument ############
dk_depend(rmlui)
dk_depend(DKAssets)
dk_depend(DKCurl)
dk_depend(DKSDLWindow)
#dk_depend(DKRmlInterface)			//Linux FIX:
dk_depend(sdl_image)





############ DKSDLRmlDocument ############
dk_set(CURRENT_PLUGIN "DKSDLRmlDocument")
dk_generateCmake(${CURRENT_PLUGIN})
dk_assets(${CURRENT_PLUGIN})
dk_set(${CURRENT_PLUGIN} "${CMAKE_CURRENT_LIST_DIR}")
dk_configure(${${CURRENT_PLUGIN}})
dk_build(${${CURRENT_PLUGIN}})