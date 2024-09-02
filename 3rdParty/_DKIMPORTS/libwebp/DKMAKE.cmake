include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/webmproject/libwebp
 

### DEPEND ###
dk_depend(giflib)
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(sdl)
dk_depend(tiff)
dk_depend(zlib)


### IMPORT ###
#dk_import(https://github.com/webmproject/libwebp.git BRANCH main)
dk_import(https://github.com/webmproject/libwebp/archive/refs/heads/main.zip)


### LINK ###
dk_include					(${LIBWEBP}																	WEBP_INCLUDE_DIR)
if(MSVC)
	WIN_dk_libDebug			(${LIBWEBP}/${triple}/${DEBUG_DIR}/libwebp.lib									WEBP_LIBRARY_DEBUG)
	WIN_dk_libRelease		(${LIBWEBP}/${triple}/${RELEASE_DIR}/libwebp.lib								WEBP_LIBRARY_RELEASE)
#elseif(APPLE)
#	APPLE_dk_libDebug		(${LIBWEBP}/${triple}/WebP.build/${DEBUG_DIR}/webpdecode.build/libwebpdecode.a)
#	APPLE_dk_libDebug		(${LIBWEBP}/${triple}/WebP.build/${DEBUG_DIR}/webpdsp.build/libwebpdsp.a)
#	APPLE_dk_libDebug		(${LIBWEBP}/${triple}/WebP.build/${DEBUG_DIR}/webpencode.build/libwebpencode.a)
#	APPLE_dk_libDebug		(${LIBWEBP}/${triple}/WebP.build/${DEBUG_DIR}/webputils.build/libwebputils.a)
#	APPLE_dk_libRelease		(${LIBWEBP}/${triple}/WebP.build/${RELEASE_DIR}/webpdecode.build/libwebpdecode.a)
#	APPLE_dk_libRelease		(${LIBWEBP}/${triple}/WebP.build/${RELEASE_DIR}/webpdsp.build/libwebpdsp.a)
#	APPLE_dk_libRelease		(${LIBWEBP}/${triple}/WebP.build/${RELEASE_DIR}/webpencode.build/libwebpencode.a)
#	APPLE_dk_libRelease		(${LIBWEBP}/${triple}/WebP.build/${RELEASE_DIR}/webputils.build/libwebputils.a)
#	
#	APPLE_dk_libDebug		(${LIBWEBP}/${triple}/${DEBUG_DIR}/libwebp.a)
#	APPLE_dk_libRelease		(${LIBWEBP}/${triple}/${RELEASE_DIR}/libwebp.a)
#	APPLE_dk_libDebug		(${LIBWEBP}/${triple}/${DEBUG_DIR}/libsharpyuv.a)
#	APPLE_dk_libRelease		(${LIBWEBP}/${triple}/${RELEASE_DIR}/libsharpyuv.a)
else()
	dk_libDebug				(${LIBWEBP}/${triple}/${DEBUG_DIR}/libwebp.a)
	dk_libRelease			(${LIBWEBP}/${triple}/${RELEASE_DIR}/libwebp.a)
endif()


### 3RDPARTY LINK ###
dk_set(LIBWEBP_CMAKE 
	-DWEBP_INCLUDE_DIR=${WEBP_INCLUDE_DIR}
	-DWEBP_LIBRARY_DEBUG=${WEBP_LIBRARY_DEBUG}
	-DWEBP_LIBRARY_RELEASE=${WEBP_LIBRARY_RELEASE})



### GENERATE ###
dk_configure				(${LIBWEBP} ${GIFLIB_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${SDL_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE})


### COMPILE ###
dk_build					(${LIBWEBP} webp)
