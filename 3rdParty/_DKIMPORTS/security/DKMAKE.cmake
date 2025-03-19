#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### security ######
# https://developer.apple.com/documentation/security?language=objc

dk_load(dk_builder)

if(NOT APPLE)
	dk_undepend(security)
	dk_return()
endif()

dk_findLibrary(Security)
