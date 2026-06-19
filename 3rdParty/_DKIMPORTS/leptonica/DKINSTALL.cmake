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


############ leptonica ############
# http://www.leptonica.org
# http://www.leptonica.org/source/leptonica-1.74.4.tar.gz
# https://tinsuke.wordpress.com/2011/02/17/how-to-cross-compiling-libraries-for-ios-armv6armv7i386
# https://github.com/DanBloomberg/leptonica.git
# https://github.com/DanBloomberg/leptonica/archive/refs/tags/1.82.0.zip
# https://github.com/DanBloomberg/leptonica/archive/96a3d7451e7d717d8a0c88436f5ff7ea7129412e.zip

dk_depend(giflib)
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(libwebp)
#dk_depend(sw)
dk_depend(tiff)
dk_depend(zlib)

dk_import()

dk_include					(${leptonica})
dk_include					(${leptonica_Tuple_Dir}/src)
dk_include					(${leptonica_Build_Dir}/src)
if(MULTI_CONFIG)
	if(Windows AND MSVC)
		dk_libDebug			(${leptonica_Tuple_Dir}/src/${Debug_Dir}/leptonica-1.84.0d.lib)
		dk_libRelease		(${leptonica_Tuple_Dir}/src/${Release_Dir}/leptonica-1.84.0.lib)
	else()
		dk_libDebug			(${leptonica_Tuple_Dir}/src/${Debug_Dir}/libleptonica.a)
		dk_libRelease		(${leptonica_Tuple_Dir}/src/${Release_Dir}/libleptonica.a)
	endif()
else()
	dk_libDebug				(${leptonica_Debug_Dir}/src/libleptonica.a)
	dk_libRelease			(${leptonica_Release_Dir}/src/libleptonica.a)
endif()

### 3RDPARTY LINK ###
dk_set(leptonica_CMAKE -DLeptonica_DIR=${leptonica_Config_Dir})

### GENERATE ###
dk_configure(${leptonica}
#	"-DCMAKE_CXX_FLAGS=/I${LIBJPEG_TURBO}/${Target_Tuple} /I${libpng} /I${libpng}/${Target_Tuple} /I${tiff}/${Target_Tuple}/libtiff" 
	-DSTATIC=ON 
	-DCMAKE_INSTALL_PREFIX=${leptonica}
	-DSW_BUILD=OFF
	${giflib_CMAKE}
	${libjpeg-turbo_CMAKE}
	${libpng_CMAKE}
	${libwebp_CMAKE}
	${tiff_CMAKE}
	${zlib_CMAKE}
)

### COMPILE ###
dk_build(${leptonica} leptonica)
