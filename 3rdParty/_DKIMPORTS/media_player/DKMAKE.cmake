#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/MediaPlayer?language=objc

if(NOT APPLE)
	dk_undepend(media_player)
	dk_return()
endif()


dk_findLibrary(MediaPlayer)
