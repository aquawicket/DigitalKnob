# http://podofo.sourceforge.net
# https://github.com/mekentosj/podofo


### DEPEND ###
dk_depend(cryptopp)
dk_depend(fontconfig)
dk_depend(freetype)
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(lua)
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
ANDROID_dk_libDebug		(${PODOFO}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libpodofo.a)
ANDROID_dk_libRelease	(${PODOFO}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libpodofo.a)
APPLE_dk_libDebug		(${PODOFO}/${OS}/src/podofo/${DEBUG_DIR}/libpodofo.a)
APPLE_dk_libRelease		(${PODOFO}/${OS}/src/podofo/${RELEASE_DIR}/libpodofo.a)
EMSCRIPTEN_dk_libDebug	(${PODOFO}/${OS}/${DEBUG_DIR}/src/podofo/libpodofo.a)
EMSCRIPTEN_dk_libRelease(${PODOFO}/${OS}/${RELEASE_DIR}/src/podofo/libpodofo.a)
LINUX_dk_libDebug		(${PODOFO}/${OS}/${DEBUG_DIR}/src/podofo/libpodofo.a)
LINUX_dk_libRelease		(${PODOFO}/${OS}/${RELEASE_DIR}/src/podofo/libpodofo.a)
RASPBERRY_dk_libDebug	(${PODOFO}/${OS}/${DEBUG_DIR}/src/podofo/libpodofo.a)
RASPBERRY_dk_libRelease	(${PODOFO}/${OS}/${RELEASE_DIR}/src/podofo/libpodofo.a)
WIN_dk_libDebug			(${PODOFO}/${OS}/src/podofo/${DEBUG_DIR}/podofo.lib)
WIN_dk_libRelease		(${PODOFO}/${OS}/src/podofo/${RELEASE_DIR}/podofo.lib)


### GENERATE ###
ANDROID_dk_configure	(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}")
EMSCRIPTEN_dk_configure	(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}")
IOSSIM_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}" -DPODOFO_NO_FONTMANAGER=ON)
IOS_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}" -DPODOFO_NO_FONTMANAGER=ON)
LINUX_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}")
MAC_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}")
RASPBERRY_dk_configure	(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}")
WIN_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=/I${LIBPNG} /I${TIFF}/${OS}/libtiff /I${ZLIB}/${OS}")


### COMPILE ###
dk_build(${PODOFO} podofo_static)
