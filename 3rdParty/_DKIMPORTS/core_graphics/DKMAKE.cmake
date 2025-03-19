#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############# core_graphics ############
# https://developer.apple.com/documentation/coregraphics?language=objc

dk_load(dk_builder)
if(NOT APPLE)
	dk_undepend(core_graphics)
	dk_return()
endif()

dk_findLibrary(CoreGraphics)
