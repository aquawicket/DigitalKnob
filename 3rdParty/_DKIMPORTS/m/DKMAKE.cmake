#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ m ############
# https://sourceware.org/newlib/libm.html

dk_validate(target_triple "dk_target_triple()")
if(ANDROID)
	dk_depend(android-ndk)
endif()
if(EMSCRIPTEN)
	dk_depend(emsdk)
endif()

dk_findLibrary(m)
