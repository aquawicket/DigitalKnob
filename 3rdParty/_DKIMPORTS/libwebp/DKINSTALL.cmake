#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ libwebp ############
# https://github.com/webmproject/libwebp
dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
dk_depend(giflib)
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(sdl)
dk_depend(tiff)
dk_depend(zlib)

### IMPORT ###
dk_import(${libwebp_Import})

### LINK ###
dk_include					(${LIBWEBP}							LIBWEBP_INCLUDE_DIR)
if(MSVC)
	dk_libDebug				(${LIBWEBP.Debug_Dir}/libwebp.lib		LIBWEBP_LIBRARY_DEBUG)
	dk_libRelease			(${LIBWEBP.Release_Dir}/libwebp.lib		LIBWEBP_LIBRARY_RELEASE)
#elseif(Apple)
#	Apple_dk_libDebug		(${LIBWEBP.Tuple_Dir}/WebP.build/${Debug_Dir}/webpdecode.build/libwebpdecode.a)
#	Apple_dk_libDebug		(${LIBWEBP.Tuple_Dir}/WebP.build/${Debug_Dir}/webpdsp.build/libwebpdsp.a)
#	Apple_dk_libDebug		(${LIBWEBP.Tuple_Dir}/WebP.build/${Debug_Dir}/webpencode.build/libwebpencode.a)
#	Apple_dk_libDebug		(${LIBWEBP.Tuple_Dir}/WebP.build/${Debug_Dir}/webputils.build/libwebputils.a)
#	Apple_dk_libRelease		(${LIBWEBP.Tuple_Dir}/WebP.build/${Release_Dir}/webpdecode.build/libwebpdecode.a)
#	Apple_dk_libRelease		(${LIBWEBP.Tuple_Dir}/WebP.build/${Release_Dir}/webpdsp.build/libwebpdsp.a)
#	Apple_dk_libRelease		(${LIBWEBP.Tuple_Dir}/WebP.build/${Release_Dir}/webpencode.build/libwebpencode.a)
#	Apple_dk_libRelease		(${LIBWEBP.Tuple_Dir}/WebP.build/${Release_Dir}/webputils.build/libwebputils.a)
#	
#	Apple_dk_libDebug		(${LIBWEBP.Debug_Dir}/libwebp.a)
#	Apple_dk_libRelease		(${LIBWEBP.Release_Dir}/libwebp.a)
#	Apple_dk_libDebug		(${LIBWEBP.Debug_Dir}/libsharpyuv.a)
#	Apple_dk_libRelease		(${LIBWEBP.Release_Dir}/libsharpyuv.a)
else()
	dk_libDebug				(${LIBWEBP.Debug_Dir}/libwebp.a)
	dk_libRelease			(${LIBWEBP.Release_Dir}/libwebp.a)
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
