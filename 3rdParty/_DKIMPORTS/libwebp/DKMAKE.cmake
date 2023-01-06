# https://github.com/webmproject/libwebp
 

### DEPEND ###
dk_depend(zlib)
dk_depend(libpng)
dk_depend(tiff)
dk_depend(libjpeg-turbo)
dk_depend(giflib)
dk_depend(sdl)


### IMPORT ###
dk_import(https://github.com/webmproject/libwebp.git BRANCH main)


### LINK ###
dk_include				(${LIBWEBP})
WIN_dk_libDebug			(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.lib)
WIN_dk_libRelease		(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.lib)
APPLE_dk_libDebug		(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpdecode.build/libwebpdecode.a)
APPLE_dk_libRelease		(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpdecode.build/libwebpdecode.a)
APPLE_dk_libDebug		(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpdsp.build/libwebpdsp.a)
APPLE_dk_libRelease		(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpdsp.build/libwebpdsp.a)
APPLE_dk_libDebug		(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpencode.build/libwebpencode.a)
APPLE_dk_libRelease		(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpencode.build/libwebpencode.a)
APPLE_dk_libDebug		(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webputils.build/libwebputils.a)
APPLE_dk_libRelease		(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webputils.build/libwebputils.a)
LINUX_dk_libDebug		(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
LINUX_dk_libRelease		(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
RASPBERRY_dk_libDebug	(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
RASPBERRY_dk_libRelease	(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
ANDROID_dk_libDebug		(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
ANDROID_dk_libRelease	(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
EMSCRIPTEN_dk_libDebug	(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
EMSCRIPTEN_dk_libRelease(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)


### 3RDPARTY LINK ###
WIN_dk_set			(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.lib -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.lib)
APPLE_dk_set		(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
LINUX_dk_set		(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
RASPBERRY_dk_set	(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
ANDROID_dk_set		(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
EMSCRIPTEN_dk_set	(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)	


### GENERATE ###
dk_queueCommand	(${DKCMAKE_BUILD} ${GIFLIB_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${SDL_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} ${LIBWEBP})


### COMPILE ###
dk_build(${LIBWEBP_FOLDER} webp)
