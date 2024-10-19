#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
# https://developer.apple.com/documentation/agl/agl?language=objc

dk_validate(triple "dk_TARGET_TRIPLE()")
if(NOT MAC)
	dk_undepend(agl)
	dk_return()
endif()


dk_depend(carbon)
dk_depend(opengl)

dk_findLibrary(AGL)
dk_define(GL_SILENCE_DEPRECATION)
