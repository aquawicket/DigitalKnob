include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://sourceware.org/newlib/libm.html

ANDROID_dk_depend(android-ndk)
EMSCRIPTEN_dk_depend(emsdk)

dk_findLibrary(m)
