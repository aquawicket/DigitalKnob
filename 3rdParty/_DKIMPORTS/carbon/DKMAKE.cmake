#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ carbon ############
# https://developer.apple.com/documentation/coreservices/carbon_core?language=objc
dk_load(dk_builder)
if(NOT MAC)
	dk_undepend(carbon)
	dk_return()
endif()

dk_findLibrary(Carbon)
