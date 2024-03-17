# https://github.com/webmproject/libwebp
 

### DEPEND ###
dk_depend(giflib)
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(sdl)
dk_depend(tiff)
dk_depend(zlib)


### IMPORT ###
dk_import(https://github.com/webmproject/libwebp.git BRANCH main)


### LINK ###
dk_include					(${LIBWEBP}																	WEBP_INCLUDE_DIR)
if(MSVC)
	WIN_dk_libDebug			(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.lib									WEBP_LIBRARY_DEBUG)
	WIN_dk_libRelease		(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.lib								WEBP_LIBRARY_RELEASE)
elseif(APPLE)
	APPLE_dk_libDebug		(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpdecode.build/libwebpdecode.a)
	APPLE_dk_libDebug		(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpdsp.build/libwebpdsp.a)
	APPLE_dk_libDebug		(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpencode.build/libwebpencode.a)
	APPLE_dk_libDebug		(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webputils.build/libwebputils.a)
	APPLE_dk_libRelease		(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpdecode.build/libwebpdecode.a)
	APPLE_dk_libRelease		(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpdsp.build/libwebpdsp.a)
	APPLE_dk_libRelease		(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpencode.build/libwebpencode.a)
	APPLE_dk_libRelease		(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webputils.build/libwebputils.a)
else()
	dk_libDebug				(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
	dk_libRelease			(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
endif()


### 3RDPARTY LINK ###
if(MSVC)
	WIN_dk_set				(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${WEBP_INCLUDE_DIR} -DWEBP_LIBRARY_DEBUG=${WEBP_LIBRARY_DEBUG} -DWEBP_LIBRARY_RELEASE=${WEBP_LIBRARY_RELEASE})
elseif(ANDROID)
	ANDROID_dk_set			(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${WEBP_INCLUDE_DIR} -DWEBP_LIBRARY_DEBUG=${WEBP_LIBRARY_DEBUG} -DWEBP_LIBRARY_RELEASE=${WEBP_LIBRARY_RELEASE})
else()
	dk_set					(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${WEBP_INCLUDE_DIR} -DWEBP_LIBRARY_DEBUG=${WEBP_LIBRARY_DEBUG} -DWEBP_LIBRARY_RELEASE=${WEBP_LIBRARY_RELEASE})
endif()


### GENERATE ###
dk_configure				(${LIBWEBP} ${GIFLIB_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${SDL_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE})


### COMPILE ###
dk_build					(${LIBWEBP} webp)
