include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/xianyi/OpenBLAS.git


### IMPORT ###
#dk_import(https://github.com/xianyi/OpenBLAS.git BRANCH develop)
dk_import(https://github.com/OpenMathLib/OpenBLAS/archive/refs/heads/develop.zip)


### LINK ###
dk_include				(${OPENBLAS})
UNIX_dk_libDebug		(${OPENBLAS}/${OS}/${DEBUG_DIR}/lib/libopenblas.a)
UNIX_dk_libRelease		(${OPENBLAS}/${OS}/${RELEASE_DIR}/lib/libopenblas.a)
WIN_TARGET_dk_libDebug			(${OPENBLAS}/${OS}/lib/DEBUG/openblas.lib)
WIN_TARGET_dk_libRelease		(${OPENBLAS}/${OS}/lib/RELEASE/openblas.lib)


### 3RDPARTY LINK ###
#dk_set(OPENBLAS_CMAKE ???) # TODO


### GENERATE ###
dk_configure(${OPENBLAS})


### COMPILE ###
dk_build(${OPENBLAS})
