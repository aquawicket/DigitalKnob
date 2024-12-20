#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://developer.apple.com/documentation/mobilecoreservices

if(NOT IOS AND NOT IOSSIM)
	dk_undepend(mobile_core_services)
	dk_return()
endif()

dk_findLibrary(MobileCoreServices)
