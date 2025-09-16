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


############ libandroid ############
# https://developer.android.com/ndk/guides/stable_apis#tracing

dk_validate(Host_Tuple ${Host_Tuple})
if(NOT Android)
	dk_disable(android)
	dk_return()
endif()

# not found on Android host devices the first time round. 
# add hints to point to the library in the ndk
dk_depend(android-ndk)

dk_findLibrary(android)
