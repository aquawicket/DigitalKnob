# https://github.com/webmproject/libwebp
 

### DEPENDS ###
dk_depend(zlib)
dk_depend(libpng)
dk_depend(tiff)
dk_depend(libjpeg-turbo)
dk_depend(giflib)
dk_depend(sdl)

dk_import(https://github.com/webmproject/libwebp)
#dk_set(LIBWEBP_MAJOR 1)
#dk_set(LIBWEBP_MINOR 0)
#dk_set(LIBWEBP_BUILD 3)
#dk_set(LIBWEBP_VERSION ${LIBWEBP_MAJOR}.${LIBWEBP_MINOR}.${LIBWEBP_BUILD})
#dk_set(LIBWEBP_NAME libwebp-${LIBWEBP_VERSION})
#dk_set(LIBWEBP_DL https://github.com/webmproject/libwebp/archive/refs/tags/v1.0.3.zip)
#dk_set(LIBWEBP ${3RDPARTY}/${LIBWEBP_NAME})
#dk_install(${LIBWEBP_DL} libwebp ${LIBWEBP})


### DKPLUGINS LINK ###
dk_include(${LIBWEBP})
WIN_dk_libDebug(${LIBWEBP}/${OS}/${DEBUG_DIR}/webp.lib)
WIN_dk_libRelease(${LIBWEBP}/${OS}/${RELEASE_DIR}/webp.lib)
APPLE_dk_libDebug(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpdecode.build/libwebpdecode.a)
APPLE_dk_libRelease(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpdecode.build/libwebpdecode.a)
APPLE_dk_libDebug(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpdsp.build/libwebpdsp.a)
APPLE_dk_libRelease(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpdsp.build/libwebpdsp.a)
APPLE_dk_libDebug(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpencode.build/libwebpencode.a)
APPLE_dk_libRelease(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpencode.build/libwebpencode.a)
APPLE_dk_libDebug(${LIBWEBP}/${OS}/WebP.build/${DEBUG_DIR}/webputils.build/libwebputils.a)
APPLE_dk_libRelease(${LIBWEBP}/${OS}/WebP.build/${RELEASE_DIR}/webputils.build/libwebputils.a)
LINUX_dk_libDebug(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
LINUX_dk_libRelease(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
RASPBERRY_dk_libDebug(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
RASPBERRY_dk_libRelease(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
ANDROID_dk_libDebug(${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
ANDROID_dk_libRelease(${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)


#TODO
### 3RDPARTY LINK ###
#WIN_dk_set(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.lib -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.lib)
#APPLE_dk_set(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
#LINUX_dk_set(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
#RASPBERRY_dk_set(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
#ANDROID_dk_set(LIBWEBP_CMAKE -DWEBP_INCLUDE_DIR=${LIBWEBP} -DWEBP_LIBRARY_DEBUG=${LIBWEBP}/${OS}/${DEBUG_DIR}/libwebp.a -DWEBP_LIBRARY_RELEASE=${LIBWEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
	

### COMPILE ###
dk_setPath(${LIBWEBP}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${ZLIB_CMAKE} ${LIBPNG_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${TIFF_CMAKE} ${GIFLIB_CMAKE} ${SDL_CMAKE} ${LIBWEBP})


WIN_dk_visualStudio(${LIBWEBP_NAME} WebP.sln webp)
MAC_dk_xcode(${LIBWEBP_NAME} webp)
IOS_dk_xcode(${LIBWEBP_NAME} webp)
IOSSIM_dk_xcode(${LIBWEBP_NAME} webp)
LINUX_dk_queueCommand(make webp)
RASPBERRY_dk_queueCommand(make webp)
ANDROID_dk_visualStudio(${LIBWEBP_NAME} libwebp.sln webp)