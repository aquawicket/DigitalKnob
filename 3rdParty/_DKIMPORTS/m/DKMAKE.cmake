#if(NOT ANDROID)
#	return()
#endif()

ANDROID_dk_depend(android-ndk)
EMSCRIPTEN_dk_depend(emsdk)

dk_findLibrary(m)
