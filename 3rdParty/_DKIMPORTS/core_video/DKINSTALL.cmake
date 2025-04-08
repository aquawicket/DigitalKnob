#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ core_video #############
# https://developer.apple.com/documentation/corevideo

dk_load(dk_builder)
if(NOT APPLE)
	dk_undepend(core_video)
	dk_return()
endif()

dk_findLibrary(CoreVideo)
