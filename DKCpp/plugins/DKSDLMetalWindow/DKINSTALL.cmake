#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSDLMetalWindow ############
dk_depend(sdl)
dk_depend(DKWindow)




############ DKSDLMetalWindow ############
dk_set(CURRENT_PLUGIN "DKSDLMetalWindow")
dk_generateCmake(DKSDLMetalWindow)
dk_assets(DKSDLMetalWindow)
dk_set(DKSDLMetalWindow "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKSDLMetalWindow")
dk_configure(${DKSDLMetalWindow})
dk_build(${DKSDLMetalWindow})
