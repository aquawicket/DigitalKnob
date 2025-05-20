#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ video_toolbox ############
# https://developer.apple.com/documentation/videotoolbox?language=objc

dk_load(dk_builder)

if(NOT Apple)
	dk_undepend(video_toolbox)
	dk_return()
endif()

dk_findLibrary(VideoToolbox)
