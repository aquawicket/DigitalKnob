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


############ libjpeg-turbo ############
# https://github.com/libjpeg-turbo/libjpeg-turbo
# https://libjpeg-turbo.org/
# https://github.com/DeviceFarmer/android-libjpeg-turbo - For Android
# https://sourceforge.net/projects/libjpeg-turbo/files/2.1.1/libjpeg-turbo-2.1.1.tar.gz/download
# https://cmake.org/cmake/help/latest/module/FindJPEG.html

dk_import()

dk_include			("${libjpeg-turbo}/src"									JPEG_INCLUDE_DIR)
dk_include			("${libjpeg-turbo_Config_Dir}"							JPEG_INCLUDE_DIR2)
dk_include			("${libjpeg-turbo}"										JPEG_INCLUDE_DIR3)

if(MSVC)
	dk_libDebug		("${libjpeg-turbo_Debug_Dir}/turbojpeg-static.lib"		JPEG_LIBRARY_DEBUG		JPEG_LIBRARY)
	dk_libRelease	("${libjpeg-turbo_Release_Dir}/turbojpeg-static.lib"	JPEG_LIBRARY_RELEASE	JPEG_LIBRARY)
else()
	dk_libDebug		("${libjpeg-turbo_Debug_Dir}/libturbojpeg.a"			JPEG_LIBRARY_DEBUG		JPEG_LIBRARY)
	dk_libRelease	("${libjpeg-turbo_Release_Dir}/libturbojpeg.a"			JPEG_LIBRARY_RELEASE	JPEG_LIBRARY)
endif()

### 3RDPARTY LINK ###
dk_set(libjpeg-turbo_CMAKE
	-DJPEG_INCLUDE_DIR=${JPEG_INCLUDE_DIR} 
	-DJPEG_INCLUDE_DIR2=${JPEG_INCLUDE_DIR2}
	-DJPEG_LIBRARY_DEBUG=${JPEG_LIBRARY_DEBUG}
	-DJPEG_LIBRARY_RELEASE=${JPEG_LIBRARY_RELEASE})
if(MSVC)
	dk_append(libjpeg-turbo_CMAKE 
		"-DCMAKE_C_FLAGS=/I${JPEG_INCLUDE_DIR} /I${JPEG_INCLUDE_DIR2} /I${JPEG_INCLUDE_DIR3}"
		"-DCMAKE_CXX_FLAGS=/I${JPEG_INCLUDE_DIR} /I${JPEG_INCLUDE_DIR2} /I${JPEG_INCLUDE_DIR3}")
else()
	dk_append(libjpeg-turbo_CMAKE
		-DENABLE_SHARED=0
		"-DCMAKE_C_FLAGS=-I${JPEG_INCLUDE_DIR} -I${JPEG_INCLUDE_DIR2} -I${JPEG_INCLUDE_DIR3}"
		"-DCMAKE_CXX_FLAGS=-I${JPEG_INCLUDE_DIR} -I${JPEG_INCLUDE_DIR2} -I${JPEG_INCLUDE_DIR3}")
	dk_append(libjpeg-turbo_CMAKE
		-DJPEG_LIBRARY=${JPEG_LIBRARY}
		"-DCMAKE_EXE_LINKER_FLAGS=${JPEG_LIBRARY}")
endif()

### GENERATE ##
dk_configure(${libjpeg-turbo} -DWITH_SIMD=OFF "-DCMAKE_C_FLAGS=-I${JPEG_INCLUDE_DIR2} -I${JPEG_INCLUDE_DIR3}")

#if(EXISTS "${JPEG_INCLUDE_DIR2}/jconfig.h")
#	dk_copy("${JPEG_INCLUDE_DIR2}/jconfig.h" "${JPEG}/jconfig.h" OVERWRITE)
#endif()

### COMPILE ###
dk_build(${libjpeg-turbo} turbojpeg-static)
