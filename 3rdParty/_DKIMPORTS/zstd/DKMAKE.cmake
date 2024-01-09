# https://github.com/facebook/zstd.git


### IMPORT ###
dk_import(https://github.com/facebook/zstd.git)


### LINK ###
dk_include					(${ZSTD}/lib)
if(MSVC)
	ANDROID_dk_libDebug		(${ZSTD}/${OS}/lib/${DEBUG_DIR}/libzstd.a)
	ANDROID_dk_libRelease	(${ZSTD}/${OS}/lib/${RELEASE_DIR}/libzstd.a)
	WIN_dk_libDebug			(${ZSTD}/${OS}/lib/${DEBUG_DIR}/zstd_static.lib)
	WIN_dk_libRelease		(${ZSTD}/${OS}/lib/${RELEASE_DIR}/zstd_static.lib)
elseif(APPLE)
	dk_libDebug				(${ZSTD}/${OS}/lib/${DEBUG_DIR}/libzstd.a)
	dk_libRelease			(${ZSTD}/${OS}/lib/${RELEASE_DIR}/libzstd.a)
else()
	dk_libDebug				(${ZSTD}/${OS}/${DEBUG_DIR}/lib/libzstd.a)
	dk_libRelease			(${ZSTD}/${OS}/${RELEASE_DIR}/lib/libzstd.a)
endif()


### 3RDPARTY LINK ###
dk_set(ZSTD_CMAKE -DZSTD_INCLUDE_DIR=${ZSTD}/lib) #TODO


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${ZSTD}/build/cmake)


### COMPILE ###
dk_build(${ZSTD})
