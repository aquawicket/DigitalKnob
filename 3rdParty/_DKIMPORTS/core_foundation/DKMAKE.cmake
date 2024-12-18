#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ core_foundation ############
# https://developer.apple.com/documentation/corefoundation
dk_load(dk_builder)
if(NOT APPLE)
	dk_undepend(core_foundation)
	dk_return()
endif()

dk_findLibrary(CoreFoundation)
