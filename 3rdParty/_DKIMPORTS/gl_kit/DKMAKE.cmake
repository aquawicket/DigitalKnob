#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/GLKit?language=objc

if(NOT APPLE)
	dk_undepend(gl_kit)
	dk_return()
endif()


dk_findLibrary(GLKit)
