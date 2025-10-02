#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ mobile_core_services ############
# https://developer.apple.com/documentation/mobilecoreservices

dk_validate(Target_Config  "dk_Target_Config()")

if(NOT Ios AND NOT Iossim)
	dk_disable(mobile_core_services)
	dk_return()
endif()

dk_findLibrary(MobileCoreServices)
