#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ media_player ############
# https://developer.apple.com/documentation/MediaPlayer?language=objc

dk_load(dk_builder)

if(NOT Apple)
	dk_undepend(media_player)
	dk_return()
endif()


dk_findLibrary(MediaPlayer)
