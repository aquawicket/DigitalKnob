#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ android ############
dk_validate(host_triple ${host_triple})
if(NOT ANDROID)
	dk_undepend(android)
	dk_return()
endif()

# not found on Android host devices the first time round. 
# add hints to point to the library in the ndk

dk_depend(android-ndk)
dk_findLibrary(android)
