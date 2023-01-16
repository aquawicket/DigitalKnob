# https://github.com/DanBloomberg/leptonica
# README: https://tinsuke.wordpress.com/2011/02/17/how-to-cross-compiling-libraries-for-ios-armv6armv7i386/
# http://www.leptonica.org
# https://github.com/DanBloomberg/leptonica/archive/refs/tags/1.82.0.zip
# http://www.leptonica.org/source/leptonica-1.74.4.tar.gz


### DEPEND ###
#dk_depend(sw)
dk_depend(zlib)
dk_depend(tiff)
dk_depend(libpng)
dk_depend(libjpeg-turbo)
dk_depend(giflib)


### IMPORT ###
dk_import(https://github.com/DanBloomberg/leptonica.git)


### LINK ###
dk_include				(${LEPTONICA})
dk_include				(${LEPTONICA}/${OS}/src)
dk_include				(${LEPTONICA}/${OS}/${RELEASE_DIR}/src)
WIN_dk_libDebug			(${LEPTONICA}/${OS}/src/${DEBUG_DIR}/leptonica-1.83.0d.lib)
WIN_dk_libRelease		(${LEPTONICA}/${OS}/src/${RELEASE_DIR}/leptonica-1.83.0.lib)
APPLE_dk_libDebug		(${LEPTONICA}/${OS}/src/${DEBUG_DIR}/libleptonica.a)
APPLE_dk_libRelease		(${LEPTONICA}/${OS}/src/${RELEASE_DIR}/libleptonica.a)
LINUX_dk_libDebug		(${LEPTONICA}/${OS}/${DEBUG_DIR}/src/libleptonica.a)
LINUX_dk_libRelease		(${LEPTONICA}/${OS}/${RELEASE_DIR}/src/libleptonica.a)
RASPBERRY_dk_libDebug	(${LEPTONICA}/${OS}/${DEBUG_DIR}/src/libleptonica.a)
RASPBERRY_dk_libRelease	(${LEPTONICA}/${OS}/${RELEASE_DIR}/src/libleptonica.a)
ANDROID_dk_libDebug		(${LEPTONICA}/${OS}/src/${DEBUG_DIR}/libleptonica.a)
ANDROID_dk_libRelease	(${LEPTONICA}/${OS}/src/${RELEASE_DIR}/libleptonica.a)
EMSCRIPTEN_dk_libDebug	(${LEPTONICA}/${OS}/${DEBUG_DIR}/src/libleptonica.a)
EMSCRIPTEN_dk_libRelease(${LEPTONICA}/${OS}/${RELEASE_DIR}/src/libleptonica.a)


### 3RDPARTY LINK ###
dk_set(LEPTONICA_CMAKE -DLeptonica_DIR=${LEPTONICA}/${OS})


### GENERATE ###
#dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/I${LIBJPEG-TURBO}/${OS} /I${LIBPNG} /I${LIBPNG}/${OS} /I${TIFF}/${OS}/libtiff" -DSTATIC=ON -DCMAKE_INSTALL_PREFIX=${LEPTONICA} -DSW_BUILD=OFF ${GIFLIB_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} ${LEPTONICA})
dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DCMAKE_INSTALL_PREFIX=${LEPTONICA} -DSW_BUILD=OFF ${GIFLIB_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} ${LEPTONICA})


### COMPILE ###
dk_build(${LEPTONICA} leptonica)
