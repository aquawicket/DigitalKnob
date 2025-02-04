#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ core_motion #############
# https://developer.apple.com/documentation/coremotion?language=objc

dk_load(dk_builder)
if(NOT APPLE)
	dk_undepend(core_motion)
	dk_return()
endif()

dk_findLibrary(CoreMotion)
