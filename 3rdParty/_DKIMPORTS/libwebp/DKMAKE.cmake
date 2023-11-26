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
dk_include				(${LIBWEBP})
ANDROID_dk_libDebug		(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
ANDROID_dk_libRelease	(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
APPLE_dk_libDebug		(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpdecode.build/libwebpdecode.a)
APPLE_dk_libDebug		(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpdsp.build/libwebpdsp.a)
APPLE_dk_libDebug		(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpencode.build/libwebpencode.a)
APPLE_dk_libDebug		(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webputils.build/libwebputils.a)
APPLE_dk_libRelease		(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpdecode.build/libwebpdecode.a)
APPLE_dk_libRelease		(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpdsp.build/libwebpdsp.a)
APPLE_dk_libRelease		(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpencode.build/libwebpencode.a)
APPLE_dk_libRelease		(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webputils.build/libwebputils.a)
EMSCRIPTEN_dk_libDebug	(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
EMSCRIPTEN_dk_libRelease(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
LINUX_dk_libDebug		(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
LINUX_dk_libRelease		(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
RASPBERRY_dk_libDebug	(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
RASPBERRY_dk_libRelease	(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
WIN_dk_libDebug			(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.lib)
WIN_dk_libRelease		(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.lib)


### 3RDPARTY LINK ###
ANDROID_dk_set		(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
APPLE_dk_set		(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
EMSCRIPTEN_dk_set	(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)	
LINUX_dk_set		(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
RASPBERRY_dk_set	(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
WIN_dk_set			(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.lib -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${GIFLIB_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${SDL_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} ${LIBWEBP})


### COMPILE ###
dk_build(${LIBWEBP} webp)
