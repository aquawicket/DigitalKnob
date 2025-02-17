#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ opensles ############
# https://www.khronos.org/opensles/

dk_validate(target_triple "dk_target_triple()")
if(NOT ANDROID AND NOT IOS AND NOT IOSSIM)
	dk_undepend(opensles)
	dk_return()
endif()

dk_findLibrary(OpenSLES)
