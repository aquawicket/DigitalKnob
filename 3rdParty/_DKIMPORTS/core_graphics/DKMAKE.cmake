#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############# core_graphics ############
# https://developer.apple.com/documentation/coregraphics?language=objc
dk_load(dk_builder)
if(NOT APPLE)
	dk_undepend(core_graphics)
	dk_return()
endif()

dk_findLibrary(CoreGraphics)
