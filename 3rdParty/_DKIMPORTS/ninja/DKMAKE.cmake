#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/ninja-build/ninja.git


#dk_import(https://github.com/ninja-build/ninja.git)
dk_import(https://github.com/ninja-build/ninja/archive/refs/heads/master.zip)


dk_include(${NINJA})

dk_libDebug(${NINJA}/${triple}/${DEBUG_DIR}/ninja.exe)
dk_libRelease(${NINJA}/${triple}/${DEBUG_DIR}/ninja.exe)

dk_configure(${NINJA})

dk_build(${NINJA})