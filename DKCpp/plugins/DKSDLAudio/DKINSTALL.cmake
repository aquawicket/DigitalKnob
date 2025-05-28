#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKSDLAudio ############
dk_depend(DKAudio)
dk_depend(DKSDLWindow)
dk_depend(sdl_mixer)



############ DKSDLAudio ############
dk_set(CURRENT_PLUGIN "DKSDLAudio")
dk_generateCmake(DKSDLAudio)
dk_assets(DKSDLAudio)
dk_set(DKSDLAudio "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKSDLAudio")
dk_configure(${DKSDLAudio})
dk_build(${DKSDLAudio})
