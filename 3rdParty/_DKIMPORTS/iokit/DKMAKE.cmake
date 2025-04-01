#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ iokit ############
# https://developer.apple.com/documentation/IOKit

if(NOT APPLE)
	dk_undepend(iokit)
	dk_return()
endif()

dk_findLibrary(IOKit)
