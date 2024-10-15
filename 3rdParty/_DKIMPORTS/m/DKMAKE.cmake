#!/usr/bin/cmake -P
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
