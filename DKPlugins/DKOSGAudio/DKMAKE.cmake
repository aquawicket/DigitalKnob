#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKOSGAudio ############
dk_depend(DKAudio)
dk_depend(DKOSGWindow)
dk_depend(osgaudio)

dk_generateCmake(DKOSGAudio)
