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


############ libjpeg-turbo ############
# https://github.com/libjpeg-turbo/libjpeg-turbo
# https://libjpeg-turbo.org/
# https://github.com/DeviceFarmer/android-libjpeg-turbo - For Android
# https://sourceforge.net/projects/libjpeg-turbo/files/2.1.1/libjpeg-turbo-2.1.1.tar.gz/download
#dk_validate(Target_Config  "dk_Target_Config()")

### IMPORT ###
dk_import()

### LINK ###
dk_include			(${libjpeg-turbo}										LIBJPEG_TURBO_INCLUDE_DIR)
dk_include			(${libjpeg-turbo_Config_Dir}							LIBJPEG_TURBO_INCLUDE_DIR2)
dk_include			(${libjpeg-turbo}/src									LIBJPEG_TURBO_INCLUDE_DIR3)

if(Windows AND MSVC)
	dk_libDebug		(${libjpeg-turbo_Debug_Dir}/turbojpeg-static.lib		LIBJPEG_TURBO_LIBRARY_DEBUG)
	dk_libRelease	(${libjpeg-turbo_Release_Dir}/turbojpeg-static.lib		LIBJPEG_TURBO_LIBRARY_RELEASE)
else()
	dk_libDebug		(${libjpeg-turbo_Debug_Dir}/libturbojpeg.a				LIBJPEG_TURBO_LIBRARY_DEBUG)
	dk_libRelease	(${libjpeg-turbo_Release_Dir}/libturbojpeg.a			LIBJPEG_TURBO_LIBRARY_RELEASE)
endif()

### 3RDPARTY LINK ###
dk_append(libjpeg-turbo_CMAKE
	#-DLIBJPEG_INCLUDE_DIR=${libjpeg-turbo}
	-DJPEG_INCLUDE_DIR=${LIBJPEG_TURBO_INCLUDE_DIR} 
	-DJPEG_INCLUDE_DIR2=${LIBJPEG_TURBO_INCLUDE_DIR2}
	-DJPEG_LIBRARY_DEBUG=${LIBJPEG_TURBO_LIBRARY_DEBUG}
	-DJPEG_LIBRARY_RELEASE=${LIBJPEG_TURBO_LIBRARY_RELEASE})
if(Windows AND MSVC)
	dk_append(libjpeg-turbo_CMAKE 
		"-DCMAKE_C_FLAGS=/I${LIBJPEG_TURBO_INCLUDE_DIR} /I${LIBJPEG_TURBO_INCLUDE_DIR2} /I${LIBJPEG_TURBO_INCLUDE_DIR3}"
		"-DCMAKE_CXX_FLAGS=/I${LIBJPEG_TURBO_INCLUDE_DIR} /I${LIBJPEG_TURBO_INCLUDE_DIR2} /I${LIBJPEG_TURBO_INCLUDE_DIR3}")
else()
	dk_append(libjpeg-turbo_CMAKE
		-DENABLE_SHARED=0
		"-DCMAKE_C_FLAGS=-I${LIBJPEG_TURBO_INCLUDE_DIR} -I${LIBJPEG_TURBO_INCLUDE_DIR2} -I${LIBJPEG_TURBO_INCLUDE_DIR3}"
		"-DCMAKE_CXX_FLAGS=-I${LIBJPEG_TURBO_INCLUDE_DIR} -I${LIBJPEG_TURBO_INCLUDE_DIR2} -I${LIBJPEG_TURBO_INCLUDE_DIR3}")
	if(Debug)
		dk_append(libjpeg-turbo_CMAKE
			#-DLIBJPEG_LIBRARY=${LIBJPEG_TURBO_LIBRARY_DEBUG} 
			-DJPEG_LIBRARY=${LIBJPEG_TURBO_LIBRARY_DEBUG}
			"-DCMAKE_EXE_LINKER_FLAGS=${LIBJPEG_TURBO_LIBRARY_DEBUG}")
	endif()
	if(Release)
		dk_append(libjpeg-turbo_CMAKE
			#-DLIBJPEG_LIBRARY=${LIBJPEG_TURBO_LIBRARY_RELEASE} 
			-DJPEG_LIBRARY=${LIBJPEG_TURBO_LIBRARY_RELEASE}
			"-DCMAKE_EXE_LINKER_FLAGS=${LIBJPEG_TURBO_LIBRARY_RELEASE}")
	endif()
endif()

### GENERATE ##
dk_configure(${libjpeg-turbo} -DWITH_SIMD=OFF "-DCMAKE_C_FLAGS=-I${LIBJPEG_TURBO_INCLUDE_DIR2}")

#if(EXISTS "${LIBJPEG_TURBO_INCLUDE_DIR2}/jconfig.h")
#	dk_copy("${LIBJPEG_TURBO_INCLUDE_DIR2}/jconfig.h" "${LIBJPEG_TURBO}/jconfig.h" OVERWRITE)
#endif()

### COMPILE ###
dk_build(${libjpeg-turbo} turbojpeg-static)
