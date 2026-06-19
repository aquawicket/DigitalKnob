#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ agl ############
# https://developer.apple.com/documentation/agl/agl?language=objc

if(NOT Mac_Host)
	dk_disable(agl)
	dk_return()
endif()

dk_validate(carbon "dk_depend(carbon)")
dk_validate(opengl "dk_depend(opengl)")

dk_findLibrary(AGL)
dk_define(GL_SILENCE_DEPRECATION)
