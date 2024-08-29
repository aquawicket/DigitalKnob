include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://sourceware.org/newlib/libm.html

ANDROID_TARGET_dk_depend(android-ndk)
EMSCRIPTEN_TARGET_dk_depend(emsdk)

dk_findLibrary(m)
