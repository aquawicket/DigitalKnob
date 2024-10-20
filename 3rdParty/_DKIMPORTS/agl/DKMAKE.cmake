#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)

dk_validate(host_triple ${host_triple})
if(NOT MAC_HOST)
	return()
endif()

###### agl ######
# https://developer.apple.com/documentation/agl/agl?language=objc

dk_depend(carbon)
dk_depend(opengl)

dk_findLibrary(AGL)
dk_define(GL_SILENCE_DEPRECATION)
