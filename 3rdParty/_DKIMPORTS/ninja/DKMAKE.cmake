# https://github.com/ninja-build/ninja.git


dk_import(https://github.com/ninja-build/ninja.git)

dk_include(${NINJA})

dk_libDebug(${NINJA}/${OS}/${DEBUG_DIR}/ninja.exe)
dk_libRelease(${NINJA}/${OS}/${DEBUG_DIR}/ninja.exe)

dk_configure(${NINJA})

dk_build(${NINJA})