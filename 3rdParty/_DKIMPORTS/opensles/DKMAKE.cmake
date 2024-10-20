#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# opensles

if(NOT ANDROID AND NOT IOS AND NOT IOSSIM)
	dk_undepend(opensles)
	dk_return()
endif()

dk_findLibrary(OpenSLES)
