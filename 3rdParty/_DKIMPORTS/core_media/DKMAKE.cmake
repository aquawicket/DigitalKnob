#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ core_media ############
# https://developer.apple.com/documentation/coremedia?language=objc

dk_load(dk_builder)
if(NOT APPLE)
	dk_undepend(core_media)
	dk_return()
endif()

dk_findLibrary(CoreMedia)
