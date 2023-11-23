# https://sourceware.org/newlib/libm.html

ANDROID_dk_depend(android-ndk)
EMSCRIPTEN_dk_depend(emsdk)

if(NOT ANDROID_HOST)
	dk_findLibrary(m)
endif()
