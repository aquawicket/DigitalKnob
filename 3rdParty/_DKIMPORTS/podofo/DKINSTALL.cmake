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


############ pofodo ############
# http://podofo.sourceforge.net
# https://github.com/mekentosj/podofo.git

dk_validate(Target_Config  "dk_Target_Config()")



### DEPEND ###
dk_depend(cryptopp)
dk_depend(fontconfig)
dk_depend(freetype)
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(lua)
dk_depend(tiff)
dk_depend(zlib)


dk_import()



### LINK ###
dk_include				(${podofo})
dk_include				(${podofo}/podofo)
dk_include				(${podofo}/${Target_Tuple})
Debug_dk_include		(${podofo_Debug_Dir})
Release_dk_include		(${podofo_Release_Dir})
Android_dk_libDebug		(${podofo_Debug_Dir}/obj/local/armeabi-v7a/libpodofo.a)
Android_dk_libRelease	(${podofo_Release_Dir}/obj/local/armeabi-v7a/libpodofo.a)
Apple_dk_libDebug		(${podofo}/${Target_Tuple}/src/podofo/${Debug_Dir}/libpodofo.a)
Apple_dk_libRelease		(${podofo}/${Target_Tuple}/src/podofo/${Release_Dir}/libpodofo.a)
Emscripten_dk_libDebug	(${podofo_Debug_Dir}/src/podofo/libpodofo.a)
Emscripten_dk_libRelease(${podofo_Release_Dir}/src/podofo/libpodofo.a)
Linux_dk_libDebug		(${podofo_Debug_Dir}/src/podofo/libpodofo.a)
Linux_dk_libRelease		(${podofo_Release_Dir}/src/podofo/libpodofo.a)
Raspberry_dk_libDebug	(${podofo_Debug_Dir}/src/podofo/libpodofo.a)
Raspberry_dk_libRelease	(${podofo_Release_Dir}/src/podofo/libpodofo.a)
Windows_dk_libDebug		(${podofo}/${Target_Tuple}/src/podofo/${Debug_Dir}/podofo.lib)
Windows_dk_libRelease	(${podofo}/${Target_Tuple}/src/podofo/${Release_Dir}/podofo.lib)


### GENERATE ###
Android_dk_configure	(${podofo} -DPODOFO_BUILD_STATIC=ON ${cryptopp_CMAKE} ${fontconfig_CMAKE} ${freetype_CMAKE} ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${lua_CMAKE} ${tiff_CMAKE} ${zlib_CMAKE} "-DCMAKE_CXX_FLAGS=-I${libpng} -I${tiff}/${Target_Tuple}/libtiff -I${zlib}/${Target_Tuple}")
Emscripten_dk_configure	(${podofo} -DPODOFO_BUILD_STATIC=ON ${cryptopp_CMAKE} ${fontconfig_CMAKE} ${freetype_CMAKE} ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${lua_CMAKE} ${tiff_CMAKE} ${zlib_CMAKE} "-DCMAKE_CXX_FLAGS=-I${libpng} -I${tiff}/${Target_Tuple}/libtiff -I${zlib}/${Target_Tuple}")
Iossim_dk_configure		(${podofo} -DPODOFO_BUILD_STATIC=ON ${cryptopp_CMAKE} ${fontconfig_CMAKE} ${freetype_CMAKE} ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${lua_CMAKE} ${tiff_CMAKE} ${zlib_CMAKE} "-DCMAKE_CXX_FLAGS=-I${libpng} -I${tiff}/${Target_Tuple}/libtiff -I${zlib}/${Target_Tuple}" -DPODOFO_NO_FONTMANAGER=ON)
Ios_dk_configure		(${podofo} -DPODOFO_BUILD_STATIC=ON ${cryptopp_CMAKE} ${fontconfig_CMAKE} ${freetype_CMAKE} ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${lua_CMAKE} ${tiff_CMAKE} ${zlib_CMAKE} "-DCMAKE_CXX_FLAGS=-I${libpng} -I${tiff}/${Target_Tuple}/libtiff -I${zlib}/${Target_Tuple}" -DPODOFO_NO_FONTMANAGER=ON)
Linux_dk_configure		(${podofo} -DPODOFO_BUILD_STATIC=ON ${cryptopp_CMAKE} ${fontconfig_CMAKE} ${freetype_CMAKE} ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${lua_CMAKE} ${tiff_CMAKE} ${zlib_CMAKE} "-DCMAKE_CXX_FLAGS=-I${libpng} -I${tiff}/${Target_Tuple}/libtiff -I${zlib}/${Target_Tuple}")
Mac_dk_configure		(${podofo} -DPODOFO_BUILD_STATIC=ON ${cryptopp_CMAKE} ${fontconfig_CMAKE} ${freetype_CMAKE} ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${lua_CMAKE} ${tiff_CMAKE} ${zlib_CMAKE} "-DCMAKE_CXX_FLAGS=-I${libpng} -I${tiff}/${Target_Tuple}/libtiff -I${zlib}/${Target_Tuple}")
Raspberry_dk_configure	(${podofo} -DPODOFO_BUILD_STATIC=ON ${cryptopp_CMAKE} ${fontconfig_CMAKE} ${freetype_CMAKE} ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${lua_CMAKE} ${tiff_CMAKE} ${zlib_CMAKE} "-DCMAKE_CXX_FLAGS=-I${libpng} -I${tiff}/${Target_Tuple}/libtiff -I${zlib}/${Target_Tuple}")
Windows_dk_configure	(${podofo} -DPODOFO_BUILD_STATIC=ON ${cryptopp_CMAKE} ${fontconfig_CMAKE} ${freetype_CMAKE} ${libjpeg-turbo_CMAKE} ${libpng_CMAKE} ${lua_CMAKE} ${tiff_CMAKE} ${zlib_CMAKE} "-DCMAKE_CXX_FLAGS=/I${libpng} /I${tiff}/${Target_Tuple}/libtiff /I${zlib}/${Target_Tuple}")


### COMPILE ###
dk_build(${podofo} podofo_static)
