#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ mobile_core_services ############
# https://developer.apple.com/documentation/mobilecoreservices

dk_load(dk_builder)

if(NOT IOS AND NOT IOSSIM)
	dk_undepend(mobile_core_services)
	dk_return()
endif()

dk_findLibrary(MobileCoreServices)
