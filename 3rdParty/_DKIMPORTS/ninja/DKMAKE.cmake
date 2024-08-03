include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/ninja-build/ninja.git


#dk_import(https://github.com/ninja-build/ninja.git)
dk_import(https://github.com/ninja-build/ninja/archive/refs/heads/master.zip)


dk_include(${NINJA})

dk_libDebug(${NINJA}/${OS}/${DEBUG_DIR}/ninja.exe)
dk_libRelease(${NINJA}/${OS}/${DEBUG_DIR}/ninja.exe)

dk_configure(${NINJA})

dk_build(${NINJA})