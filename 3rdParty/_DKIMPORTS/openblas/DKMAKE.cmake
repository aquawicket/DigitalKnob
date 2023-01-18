# https://github.com/xianyi/OpenBLAS.git


### IMPORT ###
dk_import(https://github.com/xianyi/OpenBLAS.git BRANCH develop)


### LINK ###
dk_include				(${OPENBLAS})
UNIX_dk_libDebug		(${LEPTONICA}/${OS}/${DEBUG_DIR}/libopenblasd.a)
UNIX_dk_libRelease		(${LEPTONICA}/${OS}/${RELEASE_DIR}/libopenblas.a)
WIN_dk_libDebug			(${LEPTONICA}/${OS}/${DEBUG_DIR}/openblasd.lib)
WIN_dk_libRelease		(${LEPTONICA}/${OS}/${RELEASE_DIR}/openblas.lib)


### 3RDPARTY LINK ###
#dk_set(OPENBLAS_CMAKE ???) # TODO


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${OPENBLAS})


### COMPILE ###
dk_build(${OPENBLAS})
