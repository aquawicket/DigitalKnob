#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ core_haptics ############
# https://developer.apple.com/documentation/corehaptics?language=objc

dk_load(dk_builder)
if(NOT APPLE)
	dk_undepend(core_haptics)
	dk_return()
endif()

dk_findLibrary(CoreHaptics)
