# https://github.com/webmproject/libwebp
#
# https://github.com/webmproject/libwebp/archive/refs/tags/v1.0.3.zip

### DEPENDS ###
DKDEPEND(zlib)
DKDEPEND(libpng)
DKDEPEND(tiff)
DKDEPEND(libjpeg-turbo)
DKDEPEND(giflib)
DKDEPEND(sdl2)

### VERSION ###
DKSET(WEBP_MAJOR 1)
DKSET(WEBP_MINOR 0)
DKSET(WEBP_BUILD 3)
DKSET(WEBP_VERSION ${WEBP_MAJOR}.${WEBP_MINOR}.${WEBP_BUILD})
DKSET(WEBP_NAME libwebp-${WEBP_VERSION})
DKSET(WEBP_DL https://github.com/webmproject/libwebp/archive/refs/tags/v${WEBP_VERSION}.zip)
DKSET(WEBP ${3RDPARTY}/${WEBP_NAME})


### INSTALL ###
DKINSTALL(${WEBP_DL} libwebp ${WEBP})


### DKPLUGINS LINK ###
DKINCLUDE(${WEBP})
WIN_DEBUG_LIB(${WEBP}/${OS}/${DEBUG_DIR}/libwebp.lib)
WIN_RELEASE_LIB(${WEBP}/${OS}/${RELEASE_DIR}/libwebp.lib)
APPLE_DEBUG_LIB(${WEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpdecode.build/libwebpdecode.a)
APPLE_RELEASE_LIB(${WEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpdecode.build/libwebpdecode.a)
APPLE_DEBUG_LIB(${WEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpdsp.build/libwebpdsp.a)
APPLE_RELEASE_LIB(${WEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpdsp.build/libwebpdsp.a)
APPLE_DEBUG_LIB(${WEBP}/${OS}/WebP.build/${DEBUG_DIR}/webpencode.build/libwebpencode.a)
APPLE_RELEASE_LIB(${WEBP}/${OS}/WebP.build/${RELEASE_DIR}/webpencode.build/libwebpencode.a)
APPLE_DEBUG_LIB(${WEBP}/${OS}/WebP.build/${DEBUG_DIR}/webputils.build/libwebputils.a)
APPLE_RELEASE_LIB(${WEBP}/${OS}/WebP.build/${RELEASE_DIR}/webputils.build/libwebputils.a)
LINUX_DEBUG_LIB(${WEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
LINUX_RELEASE_LIB(${WEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
RASPBERRY_DEBUG_LIB(${WEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
RASPBERRY_RELEASE_LIB(${WEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
ANDROID_DEBUG_LIB(${WEBP}/${OS}/${DEBUG_DIR}/libwebp.a)
ANDROID_RELEASE_LIB(${WEBP}/${OS}/${RELEASE_DIR}/libwebp.a)


#TODO
### 3RDPARTY LINK ###
#WIN_DKSET(WEBP_CMAKE -DWEBP_INCLUDE_DIR=${WEBP} -DWEBP_LIBRARY_DEBUG=${WEBP}/${OS}/${DEBUG_DIR}/libwebpd.lib -DWEBP_LIBRARY_RELEASE=${WEBP}/${OS}/${RELEASE_DIR}/libwebp.lib)
#APPLE_DKSET(WEBP_CMAKE -DWEBP_INCLUDE_DIR=${WEBP} -DWEBP_LIBRARY_DEBUG=${WEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${WEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
#LINUX_DKSET(WEBP_CMAKE -DWEBP_INCLUDE_DIR=${WEBP} -DWEBP_LIBRARY_DEBUG=${WEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${WEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
#RASPBERRY_DKSET(WEBP_CMAKE -DWEBP_INCLUDE_DIR=${WEBP} -DWEBP_LIBRARY_DEBUG=${WEBP}/${OS}/${DEBUG_DIR}/libwebpd.a -DWEBP_LIBRARY_RELEASE=${WEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
#ANDROID_DKSET(WEBP_CMAKE -DWEBP_INCLUDE_DIR=${WEBP} -DWEBP_LIBRARY_DEBUG=${WEBP}/${OS}/${DEBUG_DIR}/libwebp.a -DWEBP_LIBRARY_RELEASE=${WEBP}/${OS}/${RELEASE_DIR}/libwebp.a)
	

### COMPILE ###
DKSETPATH(${WEBP}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} ${ZLIB_CMAKE} ${PNG_CMAKE} ${JPEG_CMAKE} ${TIFF_CMAKE} ${GIF_CMAKE} ${SDL2_CMAKE} ${WEBP})


WIN_VS(${WEBP_NAME} WebP.sln webp)
MAC_XCODE(${WEBP_NAME} webp)
IOS_XCODE(${WEBP_NAME} webp)
IOSSIM_XCODE(${WEBP_NAME} webp)
LINUX_DKQCOMMAND(make webp)
RASPBERRY_DKQCOMMAND(make webp)
ANDROID_VS(${WEBP_NAME} libwebp.sln webp)