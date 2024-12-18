#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://developer.apple.com/documentation/quartzcore?language=objc

if(NOT APPLE)
	dk_undepend(quartz_core)
	dk_return()
endif()


dk_findLibrary(QuartzCore)
