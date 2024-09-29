#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/ForceFeedback

if(NOT MAC)
	dk_undepend(force_feedback)
	dk_return()
endif()


dk_findLibrary(ForceFeedback)
