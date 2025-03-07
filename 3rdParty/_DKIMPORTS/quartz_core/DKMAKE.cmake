#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ quartz_core ############
# https://developer.apple.com/documentation/quartzcore?language=objc

dk_load(dk_builder)

if(NOT APPLE)
	dk_undepend(quartz_core)
	dk_return()
endif()


dk_findLibrary(QuartzCore)
