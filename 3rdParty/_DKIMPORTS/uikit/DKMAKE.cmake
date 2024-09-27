#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/UIKit
if(NOT IOS)
	dk_undepend(uikit)
	dk_return()
endif()

dk_findLibrary(UIKit)
