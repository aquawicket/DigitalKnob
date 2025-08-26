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


dk_validate(Target_Config  "dk_Target_Config()")
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
dk_include				(${PODOFO}/${Target_Tuple})
Debug_dk_include		(${PODOFO_Debug_Dir})
Release_dk_include		(${PODOFO_Release_Dir})
Android_dk_libDebug		(${PODOFO_Debug_Dir}/obj/local/armeabi-v7a/libpodofo.a)
Android_dk_libRelease	(${PODOFO_Release_Dir}/obj/local/armeabi-v7a/libpodofo.a)
Apple_dk_libDebug		(${PODOFO}/${Target_Tuple}/src/podofo/${Debug_Dir}/libpodofo.a)
Apple_dk_libRelease		(${PODOFO}/${Target_Tuple}/src/podofo/${Release_Dir}/libpodofo.a)
Emscripten_dk_libDebug	(${PODOFO_Debug_Dir}/src/podofo/libpodofo.a)
Emscripten_dk_libRelease(${PODOFO_Release_Dir}/src/podofo/libpodofo.a)
Linux_dk_libDebug		(${PODOFO_Debug_Dir}/src/podofo/libpodofo.a)
Linux_dk_libRelease		(${PODOFO_Release_Dir}/src/podofo/libpodofo.a)
Raspberry_dk_libDebug	(${PODOFO_Debug_Dir}/src/podofo/libpodofo.a)
Raspberry_dk_libRelease	(${PODOFO_Release_Dir}/src/podofo/libpodofo.a)
Windows_dk_libDebug			(${PODOFO}/${Target_Tuple}/src/podofo/${Debug_Dir}/podofo.lib)
Windows_dk_libRelease		(${PODOFO}/${Target_Tuple}/src/podofo/${Release_Dir}/podofo.lib)


### GENERATE ###
Android_dk_configure	(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${Target_Tuple}/libtiff -I${ZLIB}/${Target_Tuple}")
Emscripten_dk_configure	(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${Target_Tuple}/libtiff -I${ZLIB}/${Target_Tuple}")
Iossim_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${Target_Tuple}/libtiff -I${ZLIB}/${Target_Tuple}" -DPODOFO_NO_FONTMANAGER=ON)
Ios_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${Target_Tuple}/libtiff -I${ZLIB}/${Target_Tuple}" -DPODOFO_NO_FONTMANAGER=ON)
Linux_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${Target_Tuple}/libtiff -I${ZLIB}/${Target_Tuple}")
Mac_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${Target_Tuple}/libtiff -I${ZLIB}/${Target_Tuple}")
Raspberry_dk_configure	(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${TIFF}/${Target_Tuple}/libtiff -I${ZLIB}/${Target_Tuple}")
Windows_dk_configure		(${PODOFO} -DPODOFO_BUILD_STATIC=ON ${CRYPTOPP_CMAKE} ${FONTCONFIG_CMAKE} ${FREETYPE_CMAKE} ${LIBJPEG_TURBO_CMAKE} ${LIBPNG_CMAKE} ${LUA_CMAKE} ${TIFF_CMAKE} ${ZLIB_CMAKE} "-DCMAKE_CXX_FLAGS=/I${LIBPNG} /I${TIFF}/${Target_Tuple}/libtiff /I${ZLIB}/${Target_Tuple}")


### COMPILE ###
dk_build(${PODOFO} podofo_static)
