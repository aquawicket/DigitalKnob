#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/coreservices/carbon_core?language=objc

if(NOT MAC)
	dk_undepend(carbon)
	dk_return()
endif()

dk_findLibrary(Carbon)
