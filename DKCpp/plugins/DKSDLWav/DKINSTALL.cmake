#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSDLWav ############
dk_depend(DKAudio)
dk_depend(DKSDLWindow)





############ DKSDLWav ############
dk_set(CURRENT_PLUGIN "DKSDLWav")
dk_generateCmake(DKSDLWav)
dk_assets(DKSDLWav)
dk_set(DKSDLWav "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKSDLWav")
dk_configure(${DKSDLWav})
dk_build(${DKSDLWav})
