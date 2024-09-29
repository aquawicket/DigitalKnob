#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/corevideo

if(NOT APPLE)
	dk_undepend(core_video)
	dk_return()
endif()

dk_findLibrary(CoreVideo)
