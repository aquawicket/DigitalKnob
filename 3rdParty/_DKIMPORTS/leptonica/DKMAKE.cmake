# https://github.com/DanBloomberg/leptonica
# README: https://tinsuke.wordpress.com/2011/02/17/how-to-cross-compiling-libraries-for-ios-armv6armv7i386/

# http://www.leptonica.org
#
# https://github.com/DanBloomberg/leptonica/archive/refs/tags/1.82.0.zip
# http://www.leptonica.org/source/leptonica-1.74.4.tar.gz

### DEPENDS ###
#dk_depend(sw)
dk_depend(zlib)
dk_depend(tiff)
dk_depend(libpng)
IF(ANDROID)
	dk_depend(jpeg)
ELSE()
	dk_depend(libjpeg-turbo)
ENDIF()
dk_depend(giflib)


dk_import(https://github.com/DanBloomberg/leptonica.git)
#dk_set(LEPTONICA_MAJOR 1)
#dk_set(LEPTONICA_MINOR 82)
#dk_set(LEPTONICA_BUILD 0)
#dk_set(LEPTONICA_VERSION ${LEPTONICA_MAJOR}.${LEPTONICA_MINOR}.${LEPTONICA_BUILD})
#dk_set(LEPTONICA_NAME leptonica-${LEPTONICA_VERSION})
#dk_set(LEPTONICA_DL https://github.com/DanBloomberg/leptonica/archive/refs/tags/${LEPTONICA_VERSION}.zip)
#dk_set(LEPTONICA ${3RDPARTY}/${LEPTONICA_NAME})
#dk_import(${LEPTONICA_DL} ${LEPTONICA})


### LINK ###
dk_include(${LEPTONICA})
dk_include(${LEPTONICA}/${OS}/src)
dk_include(${LEPTONICA}/${OS}/${RELEASE_DIR}/src)
WIN_dk_libDebug(${LEPTONICA}/${OS}/src/${DEBUG_DIR}/${LEPTONICA_NAME}d.lib)
WIN_dk_libRelease(${LEPTONICA}/${OS}/src/${RELEASE_DIR}/${LEPTONICA_NAME}.lib)
APPLE_dk_libDebug(${LEPTONICA}/${OS}/src/${DEBUG_DIR}/libleptonica.a)
APPLE_dk_libRelease(${LEPTONICA}/${OS}/src/${RELEASE_DIR}/libleptonica.a)
LINUX_dk_libDebug(${LEPTONICA}/${OS}/${DEBUG_DIR}/src/libleptonica.a)
LINUX_dk_libRelease(${LEPTONICA}/${OS}/${RELEASE_DIR}/src/libleptonica.a)
ANDROID_dk_libDebug(${LEPTONICA}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libleptonica.a)
ANDROID_dk_libRelease(${LEPTONICA}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libleptonica.a)


### 3rdParty Link ###
WIN_dk_set(LEPTONICA_CMAKE -DLeptonica_DIR=${LEPTONICA}/${OS})


### COMPILE ###
dk_setPath(${LEPTONICA}/${BUILD_DIR})

WIN_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DCMAKE_INSTALL_PREFIX=${LEPTONICA} -DSW_BUILD=OFF ${ZLIB_CMAKE} ${TIFF_CMAKE} ${PNG_CMAKE} ${JPEG_CMAKE} ${GIF_CMAKE} ${LEPTONICA})
WIN_dk_visualStudio(${LEPTONICA_NAME} leptonica)

MAC_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DCMAKE_INSTALL_PREFIX=${LEPTONICA} -DSW_BUILD=OFF ${ZLIB_CMAKE} ${TIFF_CMAKE} ${PNG_CMAKE} ${JPEG_CMAKE} ${GIF_CMAKE} ${LEPTONICA})
MAC_dk_xcode(${LEPTONICA_NAME} leptonica)


IOS_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DCMAKE_INSTALL_PREFIX=${LEPTONICA} -DSW_BUILD=OFF ${ZLIB_CMAKE} ${TIFF_CMAKE} ${PNG_CMAKE} ${JPEG_CMAKE} ${GIF_CMAKE} ${LEPTONICA})
IOS_dk_xcode(${LEPTONICA_NAME} leptonica)


IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DCMAKE_INSTALL_PREFIX=${LEPTONICA} -DSW_BUILD=OFF ${SDL2_CMAKE} ${TIFF_CMAKE} ${PNG_CMAKE} ${JPEG_CMAKE} ${GIF_CMAKE} ${LEPTONICA})
IOSSIM_dk_xcode(${LEPTONICA_NAME} leptonica)


LINUX_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DCMAKE_INSTALL_PREFIX=${LEPTONICA}-DSW_BUILD=OFF ${ZLIB_CMAKE} ${TIFF_CMAKE} ${PNG_CMAKE} ${JPEG_CMAKE} ${GIF_CMAKE} ${LEPTONICA})
LINUX_dk_queueCommand(make leptonica)


RASPBERRY_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DCMAKE_INSTALL_PREFIX=${LEPTONICA} -DSW_BUILD=OFF ${ZLIB_CMAKE} ${TIFF_CMAKE} ${PNG_CMAKE} ${JPEG_CMAKE} ${GIF_CMAKE} ${LEPTONICA})
RASPBERRY_dk_queueCommand(make leptonica)


ANDROID_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DCMAKE_INSTALL_PREFIX=${LEPTONICA} -DSW_BUILD=OFF ${ZLIB_CMAKE} ${TIFF_CMAKE} ${PNG_CMAKE} ${JPEG_CMAKE} ${GIF_CMAKE} ${LEPTONICA})
ANDROID_dk_visualStudio(${LEPTONICA_NAME} leptonica)
