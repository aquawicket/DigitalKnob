#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/security?language=objc

if(NOT APPLE)
	dk_undepend(security)
	dk_return()
endif()

dk_findLibrary(Security)
