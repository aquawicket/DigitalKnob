#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://openal.org/
# https://openal-soft.org/
# https://github.com/native-toolkit/openal-android
# https://openal.org/downloads/OpenAL11CoreSDK.zip
# https://www.openal-soft.org/openal-releases/openal-soft-1.21.1.tar.bz2


### DEPEND ###
dk_depend(winmm)


### IMPORT ###
if(ANDROID)	
	dk_import	(https://openal.org/downloads/OpenAL11CoreSDK.zip)
else()
	dk_import	(https://www.openal-soft.org/openal-releases/openal-soft-1.21.1.tar.bz2)
endif()


### LINK ###
dk_define					(AL_LIBTYPE_STATIC)
dk_include					(${OPENAL_DIR}/include)
dk_include					(${OPENAL_DIR}/include/AL									OPENAL_INCLUDE_DIR)
ANDROID_DEBUG_dk_include	(${OPENAL_DEBUG_DIR}/jni)
ANDROID_RELEASE_dk_include	(${OPENAL_RELEASE_DIR}/jni)
file(REMOVE ${OPENAL_INCLUDE_DIR}/stdint.h)
file(REMOVE ${OPENAL_INCLUDE_DIR}/inttypes.h)
#ANDROID_dk_libDebug		(${OPENAL_DEBUG_DIR}/libopenal.a							OPENAL_LIBRARY_DEBUG)
#ANDROID_dk_libRelease		(${OPENAL_RELEASE_DIR}/libopenal.a							OPENAL_LIBRARY_RELEASE)
ANDROID_dk_libDebug			(${OPENAL_DEBUG_DIR}/obj/local/armeabi-v7a/libopenal.a		OPENAL_LIBRARY_DEBUG)
ANDROID_dk_libRelease		(${OPENAL_RELEASE_DIR}/obj/local/armeabi-v7a/libopenal.a	OPENAL_LIBRARY_RELEASE)
APPLE_dk_libDebug			(${OPENAL_DEBUG_DIR}/libopenal.a							OPENAL_LIBRARY_DEBUG)
APPLE_dk_libRelease			(${OPENAL_RELEASE_DIR}/libopenal.a							OPENAL_LIBRARY_RELEASE)
EMSCRIPTEN_dk_libDebug		(${OPENAL_DEBUG_DIR}/libopenal.a							OPENAL_LIBRARY_DEBUG)
EMSCRIPTEN_dk_libRelease	(${OPENAL_RELEASE_DIR}/libopenal.a							OPENAL_LIBRARY_RELEASE)
LINUX_dk_libDebug			(${OPENAL_DEBUG_DIR}/libopenal.a							OPENAL_LIBRARY_DEBUG)
LINUX_dk_libRelease			(${OPENAL_RELEASE_DIR}/libopenal.a							OPENAL_LIBRARY_RELEASE)
RASPBERRY_dk_libDebug		(${OPENAL_DEBUG_DIR}/libopenal.a							OPENAL_LIBRARY_DEBUG)
RASPBERRY_dk_libRelease		(${OPENAL_RELEASE_DIR}/libopenal.a							OPENAL_LIBRARY_RELEASE)
WIN_dk_libDebug				(${OPENAL_DEBUG_DIR}/OpenAL32.lib							OPENAL_LIBRARY_DEBUG)
WIN_dk_libRelease			(${OPENAL_RELEASE_DIR}/OpenAL32.lib							OPENAL_LIBRARY_RELEASE)
DEBUG_dk_set				(OPENAL_LIBRARY												${OPENAL_LIBRARY_DEBUG})
RELEASE_dk_set				(OPENAL_LIBRARY												${OPENAL_LIBRARY_RELEASE})

### 3RDPARTY LINK ###
dk_set(OPENAL_CMAKE
	-DOPENAL_INCLUDE_DIR=${OPENAL_INCLUDE_DIR} 
	-DOPENAL_LIBRARY=${OPENAL_LIBRARY} 
	-DOPENAL_LIBRARY_DEBUG=${OPENAL_LIBRARY_DEBUG}
	-DOPENAL_LIBRARY_RELEASE=${OPENAL_LIBRARY_RELEASE})
if(MSVC)
	"-DCMAKE_C_FLAGS=/DAL_LIBTYPE_STATIC /I${OPENAL_INCLUDE_DIR}"
	"-DCMAKE_CXX_FLAGS=/DAL_LIBTYPE_STATIC /I${OPENAL_INCLUDE_DIR}"
else()
	"-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL_INCLUDE_DIR}"
	"-DCMAKE_CXX_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL_INCLUDE_DIR}" 	
endif()	



### GENERATE ###
UNIX_dk_configure	(${OPENAL_DIR} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
WIN_dk_configure	(${OPENAL_DIR} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} -DFORCE_STATIC_VCRT=ON "-DCMAKE_C_FLAGS=/DAL_LIBTYPE_STATIC")


### COMPILE ###
if(ANDROID)
	dk_ndk(${OPENAL_DIR}) 
else()
	dk_build(${OPENAL_DIR} OpenAL)
endif()
