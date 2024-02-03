# https://github.com/facebook/zstd.git


### IMPORT ###
dk_import(https://github.com/facebook/zstd.git)


### LINK ###
dk_include					(${ZSTD}/lib										ZSTD_INCLUDE_DIR)
if(MSVC)
	ANDROID_dk_libDebug		(${ZSTD}/${OS}/lib/${DEBUG_DIR}/libzstd.a			ZSTD_LIBRARY_DEBUG)
	ANDROID_dk_libRelease	(${ZSTD}/${OS}/lib/${RELEASE_DIR}/libzstd.a			ZSTD_LIBRARY_RELEASE)
	WIN_dk_libDebug			(${ZSTD}/${OS}/lib/${DEBUG_DIR}/zstd_static.lib		ZSTD_LIBRARY_DEBUG)
	WIN_dk_libRelease		(${ZSTD}/${OS}/lib/${RELEASE_DIR}/zstd_static.lib	ZSTD_LIBRARY_RELEASE)
elseif(APPLE)
	dk_libDebug				(${ZSTD}/${OS}/lib/${DEBUG_DIR}/libzstd.a			ZSTD_LIBRARY_DEBUG)
	dk_libRelease			(${ZSTD}/${OS}/lib/${RELEASE_DIR}/libzstd.a			ZSTD_LIBRARY_RELEASE)
else()
	dk_libDebug				(${ZSTD}/${OS}/${DEBUG_DIR}/lib/libzstd.a			ZSTD_LIBRARY_DEBUG)
	dk_libRelease			(${ZSTD}/${OS}/${RELEASE_DIR}/lib/libzstd.a			ZSTD_LIBRARY_RELEASE)
endif()


### 3RDPARTY LINK ###
if(MULTI_CONFIG)
	dk_set			(ZSTD_CMAKE -DZstd_INCLUDE_DIR=${ZSTD_INCLUDE_DIR} -DZstd_LIBRARY_DEBUG=${ZSTD_LIBRARY_DEBUG} -DZstd_LIBRARY_RELEASE=${ZSTD_LIBRARY_RELEASE} -DZstd_LIBRARY=${ZSTD_LIBRARY_RELEASE})
else()
	DEBUG_dk_set	(ZSTD_CMAKE -DZstd_INCLUDE_DIR=${ZSTD_INCLUDE_DIR} -DZstd_LIBRARY=${ZSTD_LIBRARY_DEBUG})
	RELEASE_dk_set	(ZSTD_CMAKE -DZstd_INCLUDE_DIR=${ZSTD_INCLUDE_DIR} -DZstd_LIBRARY=${ZSTD_LIBRARY_RELEASE})
endif()


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${ZSTD}/build/cmake)


### COMPILE ###
dk_build(${ZSTD})
