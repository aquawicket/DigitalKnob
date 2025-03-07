#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKOSGVideo ############
dk_depend(DKOSGWindow)
#dk_depend(openscenegraph osgdb_ffmpeg)

dk_generateCmake(DKOSGVideo)
dk_assets(DKOSGVideo)
