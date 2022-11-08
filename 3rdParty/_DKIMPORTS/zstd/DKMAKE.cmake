# https://github.com/facebook/zstd.git


### IMPORT ###
dk_import(https://github.com/facebook/zstd.git)


### LINK ###
dk_include			(${ZSTD}/lib)
WIN_dk_libDebug		(${ZSTD}/${OS}/${DEBUG_DIR}/zstd.lib)
WIN_dk_libRelease	(${ZSTD}/${OS}/${RELEASE_DIR}/zstd.lib)
UNIX_dk_libDebug	(${ZSTD}/${OS}/${DEBUG_DIR}/lib/libzstd.a)
UNIX_dk_libRelease	(${ZSTD}/${OS}/${RELEASE_DIR}/lib/libzstd.a)


### 3RDPARTY LINK ###
dk_set(ZSTD_CMAKE -DZSTD_INCLUDE_DIR=${ZSTD}/lib) #TODO

### GENERATE ###
dk_setPath(${ZSTD}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${ZSTD}/build/cmake)


### COMPILE ###
dk_build(${ZSTD_FOLDER})
