include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
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
#dk_import(https://github.com/mekentosj/podofo.git)
dk_import(http://sourceforge.net/projects/podofo/files/podofo/0.9.7/podofo-0.9.7.tar.gz)



### LINK ###
dk_include				(${PODOFO})
dk_include				(${PODOFO}/podofo)
dk_include				(${PODOFO}/${triple})
DEBUG_dk_include		(${PODOFO}/${triple}/${DEBUG_DIR})
RELEASE_dk_include		(${PODOFO}/${triple}/${RELEASE_DIR})
ANDROID_dk_libDebug		(${PODOFO}/${triple}/${DEBUG_DIR}/obj/local/armeabi-v7a/libpodofo.a)
ANDROID_dk_libRelease	(${PODOFO}/${triple}/${RELEASE_DIR}/obj/local/armeabi-v7a/libpodofo.a)
APPLE_dk_libDebug		(${PODOFO}/${triple}/src/podofo/${DEBUG_DIR}/libpodofo.a)
APPLE_dk_libRelease		(${PODOFO}/${triple}/src/podofo/${RELEASE_DIR}/libpodofo.a)
EMSCRIPTEN_dk_libDebug	(${PODOFO}/${triple}/${DEBUG_DIR}/src/podofo/libpodofo.a)
EMSCRIPTEN_dk_libRelease(${PODOFO}/${triple}/${RELEASE_DIR}/src/podofo/libpodofo.a)
LINUX_dk_libDebug		(${PODOFO}/${triple}/${DEBUG_DIR}/src/podofo/libpodofo.a)
LINUX_dk_libRelease		(${PODOFO}/${triple}/${RELEASE_DIR}/src/podofo/libpodofo.a)
RASPBERRY_dk_libDebug	(${PODOFO}/${triple}/${DEBUG_DIR}/src/podofo/libpodofo.a)
RASPBERRY_dk_libRelease	(${PODOFO}/${triple}/${RELEASE_DIR}/src/podofo/libpodofo.a)
WIN_dk_libDebug			(${PODOFO}/${triple}/src/podofo/${DEBUG_DIR}/podofo.lib)
WIN_dk_libRelease		(${PODOFO}/${triple}/src/podofo/${RELEASE_DIR}/podofo.lib)


### GENERATE ###
ANDROID_dk_configure	(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${triple}/libtiff -I${ZLIB}/${triple}")
EMSCRIPTEN_dk_configure	(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${triple}/libtiff -I${ZLIB}/${triple}")
IOSSIM_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${triple}/libtiff -I${ZLIB}/${triple}" -DPODOFO_NO_FONTMANAGER=ON)
IOS_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${triple}/libtiff -I${ZLIB}/${triple}" -DPODOFO_NO_FONTMANAGER=ON)
LINUX_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${triple}/libtiff -I${ZLIB}/${triple}")
MAC_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${triple}/libtiff -I${ZLIB}/${triple}")
RASPBERRY_dk_configure	(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${triple}/libtiff -I${ZLIB}/${triple}")
WIN_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=/I${LIBPNG} /I${TIFF}/${triple}/libtiff /I${ZLIB}/${triple}")


### COMPILE ###
dk_build(${PODOFO} podofo_static)
