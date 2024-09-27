#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/coregraphics?language=objc

if(NOT APPLE)
	dk_undepend(core_graphics)
	dk_return()
endif()

dk_findLibrary(CoreGraphics)
