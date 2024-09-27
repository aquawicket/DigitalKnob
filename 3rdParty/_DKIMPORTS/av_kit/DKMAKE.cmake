#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/AVKit?language=objc

if(NOT APPLE)
	dk_undepend(av_kit)
	dk_return()
endif()


dk_findLibrary(AVKit)
