#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKSDLAudio ############
dk_depend(DKAudio)
dk_depend(DKSDLWindow)
dk_depend(sdl_mixer)

dk_generateCmake(DKSDLAudio)
