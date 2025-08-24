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


############ leptonica ############
# https://github.com/DanBloomberg/leptonica
# README: https://tinsuke.wordpress.com/2011/02/17/how-to-cross-compiling-libraries-for-ios-armv6armv7i386/
# http://www.leptonica.org
# https://github.com/DanBloomberg/leptonica/archive/refs/tags/1.82.0.zip
# http://www.leptonica.org/source/leptonica-1.74.4.tar.gz

dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
dk_depend(giflib)
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(libwebp)
#dk_depend(sw)
dk_depend(tiff)
dk_depend(zlib)

### IMPORT ###
dk_import(https://github.com/DanBloomberg/leptonica/archive/96a3d745.zip)

### LINK ###
dk_include					(${LEPTONICA})
dk_include					(${LEPTONICA}/${Target_Tuple}/src)
dk_include					(${LEPTONICA.Release_Dir}/src)
if(MULTI_CONFIG)
 if(MSVC)
	Windows_dk_libDebug			(${LEPTONICA}/${Target_Tuple}/src/${Debug_Dir}/leptonica-1.84.0d.lib)
	Windows_dk_libRelease		(${LEPTONICA}/${Target_Tuple}/src/${Release_Dir}/leptonica-1.84.0.lib)
	Android_dk_libDebug		(${LEPTONICA}/${Target_Tuple}/src/${Debug_Dir}/libleptonica.a)
	Android_dk_libRelease	(${LEPTONICA}/${Target_Tuple}/src/${Release_Dir}/libleptonica.a)
 else()
	dk_libDebug				(${LEPTONICA}/${Target_Tuple}/src/${Debug_Dir}/libleptonica.a)
	dk_libRelease			(${LEPTONICA}/${Target_Tuple}/src/${Release_Dir}/libleptonica.a)
 endif()
else()
	dk_libDebug				(${LEPTONICA.Debug_Dir}/src/libleptonica.a)
	dk_libRelease			(${LEPTONICA.Release_Dir}/src/libleptonica.a)
endif()

### 3RDPARTY LINK ###
dk_set(LEPTONICA_CMAKE -DLeptonica_DIR=${LEPTONICA.Config_Dir})

### GENERATE ###
#dk_configure(${LEPTONICA} 
#	"-DCMAKE_CXX_FLAGS=/I${LIBJPEG_TURBO}/${Target_Tuple} /I${LIBPNG} /I${LIBPNG}/${Target_Tuple} /I${TIFF}/${Target_Tuple}/libtiff" 
#	-DSTATIC=ON 
#	-DCMAKE_INSTALL_PREFIX=${LEPTONICA} 
#	-DSW_BUILD=OFF 
#	${GIFLIB_CMAKE} 
#	${LIBJPEG_TURBO_CMAKE} 
#	${LIBPNG_CMAKE} 
#	${TIFF_CMAKE} 
#	${ZLIB_CMAKE})
	
dk_configure(${LEPTONICA} 
	-DSTATIC=ON 
	-DCMAKE_INSTALL_PREFIX=${LEPTONICA}
	-DSW_BUILD=OFF
	${GIFLIB_CMAKE}
	${LIBJPEG_TURBO_CMAKE}
	${LIBPNG_CMAKE}
	${LIBWEBP_CMAKE}
	${TIFF_CMAKE}
	${ZLIB_CMAKE})

### COMPILE ###
dk_build(${LEPTONICA} leptonica)
