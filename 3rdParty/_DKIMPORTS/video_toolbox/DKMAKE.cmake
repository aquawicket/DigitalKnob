#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://developer.apple.com/documentation/videotoolbox?language=objc

if(NOT APPLE)
	dk_undepend(video_toolbox)
	dk_return()
endif()

dk_findLibrary(VideoToolbox)
