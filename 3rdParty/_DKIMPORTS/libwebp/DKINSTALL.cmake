#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libwebp ############
# https://github.com/webmproject/libwebp
dk_load(dk_builder)

### DEPEND ###
dk_depend(giflib)
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(sdl)
dk_depend(tiff)
dk_depend(zlib)

### IMPORT ###
dk_import(https://github.com/webmproject/libwebp/archive/84b118c9.zip)

### LINK ###
dk_include					(${LIBWEBP_DIR}							LIBWEBP_INCLUDE_DIR)
if(MSVC)
	dk_libDebug				(${LIBWEBP_DEBUG_DIR}/libwebp.lib		LIBWEBP_LIBRARY_DEBUG)
	dk_libRelease			(${LIBWEBP_RELEASE_DIR}/libwebp.lib		LIBWEBP_LIBRARY_RELEASE)
#elseif(Apple)
#	APPLE_dk_libDebug		(${LIBWEBP_TUPLE_DIR}/WebP.build/${DEBUG_DIR}/webpdecode.build/libwebpdecode.a)
#	APPLE_dk_libDebug		(${LIBWEBP_TUPLE_DIR}/WebP.build/${DEBUG_DIR}/webpdsp.build/libwebpdsp.a)
#	APPLE_dk_libDebug		(${LIBWEBP_TUPLE_DIR}/WebP.build/${DEBUG_DIR}/webpencode.build/libwebpencode.a)
#	APPLE_dk_libDebug		(${LIBWEBP_TUPLE_DIR}/WebP.build/${DEBUG_DIR}/webputils.build/libwebputils.a)
#	APPLE_dk_libRelease		(${LIBWEBP_TUPLE_DIR}/WebP.build/${RELEASE_DIR}/webpdecode.build/libwebpdecode.a)
#	APPLE_dk_libRelease		(${LIBWEBP_TUPLE_DIR}/WebP.build/${RELEASE_DIR}/webpdsp.build/libwebpdsp.a)
#	APPLE_dk_libRelease		(${LIBWEBP_TUPLE_DIR}/WebP.build/${RELEASE_DIR}/webpencode.build/libwebpencode.a)
#	APPLE_dk_libRelease		(${LIBWEBP_TUPLE_DIR}/WebP.build/${RELEASE_DIR}/webputils.build/libwebputils.a)
#	
#	APPLE_dk_libDebug		(${LIBWEBP_DEBUG_DIR}/libwebp.a)
#	APPLE_dk_libRelease		(${LIBWEBP_RELEASE_DIR}/libwebp.a)
#	APPLE_dk_libDebug		(${LIBWEBP_DEBUG_DIR}/libsharpyuv.a)
#	APPLE_dk_libRelease		(${LIBWEBP_RELEASE_DIR}/libsharpyuv.a)
else()
	dk_libDebug				(${LIBWEBP_DEBUG_DIR}/libwebp.a)
	dk_libRelease			(${LIBWEBP_RELEASE_DIR}/libwebp.a)
endif()

### 3RDPARTY LINK ###
dk_set(LIBWEBP_CMAKE 
	-DWEBP_INCLUDE_DIR=${LIBWEBP_INCLUDE_DIR}
	-DWEBP_LIBRARY_DEBUG=${LIBWEBP_LIBRARY_DEBUG}
	-DWEBP_LIBRARY_RELEASE=${LIBWEBP_LIBRARY_RELEASE})

### GENERATE ###
dk_configure				(${LIBWEBP} ${GIFLIB_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${SDL_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE})

### COMPILE ###
dk_build					(${LIBWEBP} webp)
