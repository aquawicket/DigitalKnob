# http://podofo.sourceforge.net
# https://github.com/mekentosj/podofo


### DEPEND ###
dk_depend(cryptopp)
dk_depend(freetype)
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(tiff)
dk_depend(zlib)


### IMPORT ###
dk_import(http://sourceforge.net/projects/podofo/files/podofo/0.9.7/podofo-0.9.7.tar.gz)
#dk_import(https://github.com/mekentosj/podofo.git)


### LINK ###
dk_include				(${PODOFO})
dk_include				(${PODOFO}/podofo)
dk_include				(${PODOFO}/${OS})
DEBUG_dk_include		(${PODOFO}/${OS}/${DEBUG_DIR})
RELEASE_dk_include		(${PODOFO}/${OS}/${RELEASE_DIR})
WIN_dk_libDebug			(${PODOFO}/${OS}/src/podofo/${DEBUG_DIR}/podofo.lib)
WIN_dk_libRelease		(${PODOFO}/${OS}/src/podofo/${RELEASE_DIR}/podofo.lib)
APPLE_dk_libDebug		(${PODOFO}/${OS}/src/podofo/${DEBUG_DIR}/libpodofo.a)
APPLE_dk_libRelease		(${PODOFO}/${OS}/src/podofo/${RELEASE_DIR}/libpodofo.a)
LINUX_dk_libDebug		(${PODOFO}/${OS}/${DEBUG_DIR}/src/podofo/libpodofo.a)
LINUX_dk_libRelease		(${PODOFO}/${OS}/${RELEASE_DIR}/src/podofo/libpodofo.a)
RASPBERRY_dk_libDebug	(${PODOFO}/${OS}/${DEBUG_DIR}/src/podofo/libpodofo.a)
RASPBERRY_dk_libRelease	(${PODOFO}/${OS}/${RELEASE_DIR}/src/podofo/libpodofo.a)
ANDROID_dk_libDebug		(${PODOFO}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libpodofo.a)
ANDROID_dk_libRelease	(${PODOFO}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libpodofo.a)
EMSCRIPTEN_dk_libDebug	(${PODOFO}/${OS}/${DEBUG_DIR}/src/podofo/libpodofo.a)
EMSCRIPTEN_dk_libRelease(${PODOFO}/${OS}/${RELEASE_DIR}/src/podofo/libpodofo.a)


### GENERATE ###
WIN_dk_queueCommand			(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=/I${LIBPNG} /I${TIFF}/${OS}/libtiff /I${ZLIB}/${OS}" ${PODOFO})
MAC_dk_queueCommand			(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}" ${PODOFO})
IOS_dk_queueCommand			(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}" -DPODOFO_NO_FONTMANAGER=ON ${PODOFO})
IOSSIM_dk_queueCommand		(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}" -DPODOFO_NO_FONTMANAGER=ON ${PODOFO})
LINUX_dk_queueCommand		(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}" ${PODOFO})
RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}" ${PODOFO})
ANDROID_dk_queueCommand		(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}" ${PODOFO})
EMSCRIPTEN_dk_queueCommand	(${DKCMAKE_BUILD} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${LIBPNG_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}" ${PODOFO})


### COMPILE ###
dk_build(${PODOFO} podofo_static)
