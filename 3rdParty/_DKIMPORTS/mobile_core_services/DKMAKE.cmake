#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/mobilecoreservices

if(NOT IOS AND NOT IOSSIM)
	dk_undepend(mobile_core_services)
	dk_return()
endif()

dk_findLibrary(MobileCoreServices)
