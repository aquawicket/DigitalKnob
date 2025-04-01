#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKOSGAudio ############
dk_depend(DKAudio)
dk_depend(DKOSGWindow)
dk_depend(osgaudio)

dk_generateCmake(DKOSGAudio)
