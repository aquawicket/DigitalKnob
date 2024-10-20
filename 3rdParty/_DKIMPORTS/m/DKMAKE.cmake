#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


# https://sourceware.org/newlib/libm.html

dk_validate(triple "dk_TARGET_TRIPLE()")
if(ANDROID)
	dk_depend(android-ndk)
endif()
if(EMSCRIPTEN)
	dk_depend(emsdk)
endif()

dk_findLibrary(m)
