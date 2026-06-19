#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ libwebp ############
# https://github.com/webmproject/libwebp

### DEPEND ###
dk_depend(giflib)
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(sdl)
dk_depend(tiff)
dk_depend(zlib)

### IMPORT ###
dk_import()

### LINK ###
dk_include					(${libwebp}								LIBWEBP_INCLUDE_DIR)
if(MSVC)
	dk_libDebug				(${libwebp_Debug_Dir}/libwebp.lib		LIBWEBP_LIBRARY_DEBUG)
	dk_libRelease			(${libwebp_Release_Dir}/libwebp.lib		LIBWEBP_LIBRARY_RELEASE)
#elseif(Apple)
#	Apple_dk_libDebug		(${libwebp_Tuple_Dir}/WebP.build/${Debug_Dir}/webpdecode.build/libwebpdecode.a)
#	Apple_dk_libDebug		(${libwebp_Tuple_Dir}/WebP.build/${Debug_Dir}/webpdsp.build/libwebpdsp.a)
#	Apple_dk_libDebug		(${libwebp_Tuple_Dir}/WebP.build/${Debug_Dir}/webpencode.build/libwebpencode.a)
#	Apple_dk_libDebug		(${libwebp_Tuple_Dir}/WebP.build/${Debug_Dir}/webputils.build/libwebputils.a)
#	Apple_dk_libRelease		(${libwebp_Tuple_Dir}/WebP.build/${Release_Dir}/webpdecode.build/libwebpdecode.a)
#	Apple_dk_libRelease		(${libwebp_Tuple_Dir}/WebP.build/${Release_Dir}/webpdsp.build/libwebpdsp.a)
#	Apple_dk_libRelease		(${libwebp_Tuple_Dir}/WebP.build/${Release_Dir}/webpencode.build/libwebpencode.a)
#	Apple_dk_libRelease		(${libwebp_Tuple_Dir}/WebP.build/${Release_Dir}/webputils.build/libwebputils.a)
#	
#	Apple_dk_libDebug		(${libwebp_Debug_Dir}/libwebp.a)
#	Apple_dk_libRelease		(${libwebp_Release_Dir}/libwebp.a)
#	Apple_dk_libDebug		(${libwebp_Debug_Dir}/libsharpyuv.a)
#	Apple_dk_libRelease		(${libwebp_Release_Dir}/libsharpyuv.a)
else()
	dk_libDebug				(${libwebp_Debug_Dir}/libwebp.a			LIBWEBP_LIBRARY_DEBUG)
	dk_libRelease			(${libwebp_Release_Dir}/libwebp.a		LIBWEBP_LIBRARY_RELEASE)
endif()

### 3RDPARTY LINK ###
dk_set(libwebp_CMAKE 
	-DWEBP_INCLUDE_DIR=${LIBWEBP_INCLUDE_DIR}
	-DWEBP_LIBRARY_DEBUG=${LIBWEBP_LIBRARY_DEBUG}
	-DWEBP_LIBRARY_RELEASE=${LIBWEBP_LIBRARY_RELEASE})

### GENERATE ###
dk_configure(${libwebp} ${giflib_CMAKE} ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${sdl_CMAKE} ${tiff_CMAKE} ${zlib_CMAKE})

### COMPILE ###
dk_build	(${libwebp} webp)
