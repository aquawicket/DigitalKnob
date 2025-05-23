#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libjpeg-turbo ############
# https://github.com/libjpeg-turbo/libjpeg-turbo
# https://libjpeg-turbo.org/
# For ANDROID - https://github.com/DeviceFarmer/android-libjpeg-turbo
# https://sourceforge.net/projects/libjpeg-turbo/files/2.1.1/libjpeg-turbo-2.1.1.tar.gz/download
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/libjpeg-turbo/libjpeg-turbo/archive/a927b489.zip)

### LINK ###
dk_include			(${LIBJPEG_TURBO_DIR}									LIBJPEG_TURBO_INCLUDE_DIR)
dk_include			(${LIBJPEG_TURBO_CONFIG_DIR}							LIBJPEG_TURBO_INCLUDE_DIR2)
dk_include			(${LIBJPEG_TURBO_DIR}/src								LIBJPEG_TURBO_INCLUDE_DIR3)

if(WIN AND MSVC)
	dk_libDebug		(${LIBJPEG_TURBO_DEBUG_DIR}/turbojpeg-static.lib		LIBJPEG_TURBO_LIBRARY_DEBUG)
	dk_libRelease	(${LIBJPEG_TURBO_RELEASE_DIR}/turbojpeg-static.lib		LIBJPEG_TURBO_LIBRARY_RELEASE)
else()
	dk_libDebug		(${LIBJPEG_TURBO_DEBUG_DIR}/libturbojpeg.a				LIBJPEG_TURBO_LIBRARY_DEBUG)
	dk_libRelease	(${LIBJPEG_TURBO_RELEASE_DIR}/libturbojpeg.a			LIBJPEG_TURBO_LIBRARY_RELEASE)
endif()

### 3RDPARTY LINK ###
dk_append(LIBJPEG_TURBO_CMAKE
	#-DLIBJPEG_INCLUDE_DIR=${LIBJPEG_TURBO_DIR}
	-DJPEG_INCLUDE_DIR=${LIBJPEG_TURBO_INCLUDE_DIR} 
	-DJPEG_INCLUDE_DIR2=${LIBJPEG_TURBO_INCLUDE_DIR2}
	-DJPEG_LIBRARY_DEBUG=${LIBJPEG_TURBO_LIBRARY_DEBUG}
	-DJPEG_LIBRARY_RELEASE=${LIBJPEG_TURBO_LIBRARY_RELEASE})
if(WIN AND MSVC)
	dk_append(LIBJPEG_TURBO_CMAKE 
		"-DCMAKE_C_FLAGS=/I${LIBJPEG_TURBO_INCLUDE_DIR} /I${LIBJPEG_TURBO_INCLUDE_DIR2} /I${LIBJPEG_TURBO_INCLUDE_DIR3}"
		"-DCMAKE_CXX_FLAGS=/I${LIBJPEG_TURBO_INCLUDE_DIR} /I${LIBJPEG_TURBO_INCLUDE_DIR2} /I${LIBJPEG_TURBO_INCLUDE_DIR3}")
else()
	dk_append(LIBJPEG_TURBO_CMAKE
		-DENABLE_SHARED=0
		"-DCMAKE_C_FLAGS=-I${LIBJPEG_TURBO_INCLUDE_DIR} -I${LIBJPEG_TURBO_INCLUDE_DIR2} -I${LIBJPEG_TURBO_INCLUDE_DIR3}"
		"-DCMAKE_CXX_FLAGS=-I${LIBJPEG_TURBO_INCLUDE_DIR} -I${LIBJPEG_TURBO_INCLUDE_DIR2} -I${LIBJPEG_TURBO_INCLUDE_DIR3}")
	if(DEBUG)
		dk_append(LIBJPEG_TURBO_CMAKE
			#-DLIBJPEG_LIBRARY=${LIBJPEG_TURBO_LIBRARY_DEBUG} 
			-DJPEG_LIBRARY=${LIBJPEG_TURBO_LIBRARY_DEBUG}
			"-DCMAKE_EXE_LINKER_FLAGS=${LIBJPEG_TURBO_LIBRARY_DEBUG}")
	endif()
	if(RELEASE)
		dk_append(LIBJPEG_TURBO_CMAKE
			#-DLIBJPEG_LIBRARY=${LIBJPEG_TURBO_LIBRARY_RELEASE} 
			-DJPEG_LIBRARY=${LIBJPEG_TURBO_LIBRARY_RELEASE}
			"-DCMAKE_EXE_LINKER_FLAGS=${LIBJPEG_TURBO_LIBRARY_RELEASE}")
	endif()
endif()

### GENERATE ##
dk_configure(${LIBJPEG_TURBO_DIR} -DWITH_SIMD=OFF "-DCMAKE_C_FLAGS=-I${LIBJPEG_TURBO_INCLUDE_DIR2}")

#if(EXISTS "${LIBJPEG_TURBO_INCLUDE_DIR2}/jconfig.h")
#	dk_copy("${LIBJPEG_TURBO_INCLUDE_DIR2}/jconfig.h" "${LIBJPEG_TURBO_DIR}/jconfig.h" OVERWRITE)
#endif()

### COMPILE ###
dk_build(${LIBJPEG_TURBO_DIR} turbojpeg-static)
