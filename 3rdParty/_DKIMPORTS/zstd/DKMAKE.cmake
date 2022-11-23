# https://github.com/facebook/zstd.git


### IMPORT ###
dk_import(https://github.com/facebook/zstd.git)


### LINK ###
dk_include				(${ZSTD}/lib)
WIN_dk_libDebug			(${ZSTD}/${OS}/lib/${DEBUG_DIR}/zstd_static.lib)
WIN_dk_libRelease		(${ZSTD}/${OS}/lib/${RELEASE_DIR}/zstd_static.lib)
APPLE_dk_libDebug		(${ZSTD}/${OS}/lib/${DEBUG_DIR}/libzstd.a)
APPLE_dk_libRelease		(${ZSTD}/${OS}/lib/${RELEASE_DIR}/libzstd.a)
LINUX_dk_libDebug		(${ZSTD}/${OS}/${DEBUG_DIR}/lib/libzstd.a)
LINUX_dk_libRelease		(${ZSTD}/${OS}/${RELEASE_DIR}/lib/libzstd.a)
RASPBERRY_dk_libDebug	(${ZSTD}/${OS}/${DEBUG_DIR}/lib/libzstd.a)
RASPBERRY_dk_libRelease	(${ZSTD}/${OS}/${RELEASE_DIR}/lib/libzstd.a)
ANDROID_dk_libDebug		(${ZSTD}/${OS}/${DEBUG_DIR}/libzstd.a)
ANDROID_dk_libRelease	(${ZSTD}/${OS}/${RELEASE_DIR}/libzstd.a)


### 3RDPARTY LINK ###
dk_set(ZSTD_CMAKE -DZSTD_INCLUDE_DIR=${ZSTD}/lib) #TODO


### GENERATE ###
#dk_setPath(${ZSTD}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${ZSTD}/build/cmake)


### COMPILE ###
dk_build(${ZSTD_FOLDER})
