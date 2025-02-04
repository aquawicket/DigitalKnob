#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ metalkit ############
# https://developer.apple.com/documentation/metal?language=objc

dk_load(dk_builder)

if(NOT APPLE)
	dk_undepend(metalkit)
	dk_return()
endif()

dk_findLibrary(MetalKit)