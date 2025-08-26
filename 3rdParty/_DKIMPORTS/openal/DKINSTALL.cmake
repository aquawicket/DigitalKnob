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


############ openal ############
# https://openal.org/
# https://openal-soft.org/
# https://github.com/native-toolkit/openal-android
# https://openal.org/downloads/OpenAL11CoreSDK.zip
# https://www.openal-soft.org/openal-releases/openal-soft-1.21.1.tar.bz2
dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
dk_depend(winmm)

### IMPORT ###
if(Android)	
	dk_import	(https://openal.org/downloads/OpenAL11CoreSDK.zip)
else()
	dk_import	(https://www.openal-soft.org/openal-releases/openal-soft-1.21.1.tar.bz2)
endif()


### LINK ###
dk_define					(AL_LIBTYPE_STATIC)
dk_include					(${OPENAL}/include)
dk_include					(${OPENAL}/include/AL										OPENAL_INCLUDE_DIR)
if(Android AND Debug)
	dk_include				(${OPENAL_Debug_Dir}/jni)
endif()
if(Android AND Release)	
	dk_include				(${OPENAL_Release_Dir}/jni)
endif()
#dk_rename("${OPENAL_INCLUDE_DIR}/stdint.h" "${OPENAL_INCLUDE_DIR}/stdint.h_BACKUP")
#dk_rename("${OPENAL_INCLUDE_DIR}/inttypes.h" "${OPENAL_INCLUDE_DIR}/inttypes.h_BACKUP")


if(Android AND Debug)
	dk_libDebug				("${OPENAL_Debug_Dir}/obj/local/armeabi-v7a/libopenal.a"	OPENAL_LIBRARY_DEBUG)
elseif(Android AND Release)
	dk_libRelease			("${OPENAL_Release_Dir}/obj/local/armeabi-v7a/libopenal.a"	OPENAL_LIBRARY_RELEASE)
elseif(Windows AND Debug)
	dk_libDebug				("${OPENAL_Debug_Dir}/OpenAL32.lib"							OPENAL_LIBRARY_DEBUG)
elseif(Windows AND Release)
	dk_libRelease			("${OPENAL_Release_Dir}/OpenAL32.lib"						OPENAL_LIBRARY_RELEASE)
elseif(Debug)
	dk_libDebug				("${OPENAL_Debug_Dir}/libopenal.a"							OPENAL_LIBRARY_DEBUG)
elseif(Release)
	dk_libRelease			("${OPENAL_Release_Dir}/libopenal.a"						OPENAL_LIBRARY_RELEASE)
endif()

if(Debug)
	dk_set(OPENAL_LIBRARY	${OPENAL_LIBRARY_DEBUG})
elseif(Release)
	dk_set(OPENAL_LIBRARY	${OPENAL_LIBRARY_RELEASE})
endif()

### 3RDPARTY LINK ###
dk_set(OPENAL_CMAKE
	-DOPENAL_INCLUDE_DIR=${OPENAL_INCLUDE_DIR} 
	-DOPENAL_LIBRARY=${OPENAL_LIBRARY} 
	-DOPENAL_LIBRARY_DEBUG=${OPENAL_LIBRARY_DEBUG}
	-DOPENAL_LIBRARY_RELEASE=${OPENAL_LIBRARY_RELEASE})
if(MSVC)
	dk_append(OPENAL_CMAKE
		"-DCMAKE_C_FLAGS=/DAL_LIBTYPE_STATIC /I${OPENAL_INCLUDE_DIR}"
		"-DCMAKE_CXX_FLAGS=/DAL_LIBTYPE_STATIC /I${OPENAL_INCLUDE_DIR}")
else()
	dk_append(OPENAL_CMAKE
		"-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL_INCLUDE_DIR}"
		"-DCMAKE_CXX_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL_INCLUDE_DIR}")
endif()	



### GENERATE ###
#if(Unix)
	dk_configure(${OPENAL} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
#elseif(Windows)
#	dk_configure(${OPENAL} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} -DFORCE_STATIC_VCRT=ON "-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC")
#endif()


### COMPILE ###
if(Android)
	dk_ndk()
else()
	dk_build(${OPENAL} OpenAL)
endif()
