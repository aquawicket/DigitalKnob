#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/xianyi/OpenBLAS.git


### IMPORT ###
#dk_import(https://github.com/xianyi/OpenBLAS.git BRANCH develop)
dk_import(https://github.com/OpenMathLib/OpenBLAS/archive/refs/heads/develop.zip)


### LINK ###
dk_include				(${OPENBLAS})
UNIX_dk_libDebug		(${OPENBLAS_DEBUG_DIR}/lib/libopenblas.a)
UNIX_dk_libRelease		(${OPENBLAS_RELEASE_DIR}/lib/libopenblas.a)
WIN_dk_libDebug			(${OPENBLAS_CONFIG_DIR}/lib/DEBUG/openblas.lib)
WIN_dk_libRelease		(${OPENBLAS_CONFIG_DIR}/lib/RELEASE/openblas.lib)


### 3RDPARTY LINK ###
#dk_set(OPENBLAS_CMAKE ???) # TODO


### GENERATE ###
dk_configure(${OPENBLAS})


### COMPILE ###
dk_build(${OPENBLAS})
