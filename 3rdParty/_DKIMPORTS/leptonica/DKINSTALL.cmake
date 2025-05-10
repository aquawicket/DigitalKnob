#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ leptonica ############
# https://github.com/DanBloomberg/leptonica
# README: https://tinsuke.wordpress.com/2011/02/17/how-to-cross-compiling-libraries-for-ios-armv6armv7i386/
# http://www.leptonica.org
# https://github.com/DanBloomberg/leptonica/archive/refs/tags/1.82.0.zip
# http://www.leptonica.org/source/leptonica-1.74.4.tar.gz

dk_load(dk_builder)

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
dk_include					(${LEPTONICA}/${Target_Triple}/src)
dk_include					(${LEPTONICA_RELEASE_DIR}/src)
if(MULTI_CONFIG)
 if(MSVC)
	WIN_dk_libDebug			(${LEPTONICA}/${Target_Triple}/src/${DEBUG_DIR}/leptonica-1.84.0d.lib)
	WIN_dk_libRelease		(${LEPTONICA}/${Target_Triple}/src/${RELEASE_DIR}/leptonica-1.84.0.lib)
	ANDROID_dk_libDebug		(${LEPTONICA}/${Target_Triple}/src/${DEBUG_DIR}/libleptonica.a)
	ANDROID_dk_libRelease	(${LEPTONICA}/${Target_Triple}/src/${RELEASE_DIR}/libleptonica.a)
 else()
	dk_libDebug				(${LEPTONICA}/${Target_Triple}/src/${DEBUG_DIR}/libleptonica.a)
	dk_libRelease			(${LEPTONICA}/${Target_Triple}/src/${RELEASE_DIR}/libleptonica.a)
 endif()
else()
	dk_libDebug				(${LEPTONICA_DEBUG_DIR}/src/libleptonica.a)
	dk_libRelease			(${LEPTONICA_RELEASE_DIR}/src/libleptonica.a)
endif()

### 3RDPARTY LINK ###
dk_set(LEPTONICA_CMAKE -DLeptonica_DIR=${LEPTONICA_CONFIG_DIR})

### GENERATE ###
#dk_configure(${LEPTONICA_DIR} 
#	"-DCMAKE_CXX_FLAGS=/I${LIBJPEG_TURBO}/${Target_Triple} /I${LIBPNG} /I${LIBPNG}/${Target_Triple} /I${TIFF}/${Target_Triple}/libtiff" 
#	-DSTATIC=ON 
#	-DCMAKE_INSTALL_PREFIX=${LEPTONICA} 
#	-DSW_BUILD=OFF 
#	${GIFLIB_CMAKE} 
#	${LIBJPEG_TURBO_CMAKE} 
#	${LIBPNG_CMAKE} 
#	${TIFF_CMAKE} 
#	${ZLIB_CMAKE})
	
dk_configure(${LEPTONICA_DIR} 
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
dk_build(${LEPTONICA_DIR} leptonica)
