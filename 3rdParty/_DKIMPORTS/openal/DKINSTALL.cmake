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


############ openal ############
# https://openal.org/
# https://openal-soft.org/
# https://github.com/native-toolkit/openal-android
# https://openal.org/downloads/OpenAL11CoreSDK.zip
# https://www.openal-soft.org/openal-releases
# https://www.openal-soft.org/openal-releases/openal-soft-1.21.1.tar.bz2
# https://ftp.fau.de/macports/distfiles/openal-soft/
# https://ftp.fau.de/macports/distfiles/openal-soft/openal-soft-1.21.1.tar.bz2
# https://ftp.fau.de/macports/distfiles/openal-soft/openal-soft-1.24.2.tar.bz2

dk_depend(winmm)

dk_import()

dk_define			(AL_LIBTYPE_STATIC)
dk_include			(${openal}/include)
dk_include			(${openal}/include/AL										OPENAL_INCLUDE_DIR)
if(Android)
	dk_include		(${openal_Build_Dir}/jni)
endif()
#dk_rename("${OPENAL_INCLUDE_DIR}/stdint.h" 	"${OPENAL_INCLUDE_DIR}/stdint.h_BACKUP")
#dk_rename("${OPENAL_INCLUDE_DIR}/inttypes.h" 	"${OPENAL_INCLUDE_DIR}/inttypes.h_BACKUP")


if(Android)
	dk_libDebug		("${openal_Build_Dir}/obj/local/armeabi-v7a/libopenal.a"	OPENAL_LIBRARY_DEBUG	OPENAL_LIBRARY)
	dk_libRelease	("${openal_Build_Dir}/obj/local/armeabi-v7a/libopenal.a"	OPENAL_LIBRARY_RELEASE	OPENAL_LIBRARY)
elseif(Windows)
	dk_libDebug		("${openal_Build_Dir}/OpenAL32.lib"							OPENAL_LIBRARY_DEBUG	OPENAL_LIBRARY)
	dk_libRelease	("${openal_Build_Dir}/OpenAL32.lib"							OPENAL_LIBRARY_RELEASE	OPENAL_LIBRARY)
else()
	dk_libDebug		("${openal_Build_Dir}/libopenal.a"							OPENAL_LIBRARY_DEBUG	OPENAL_LIBRARY)
	dk_libRelease	("${openal_Build_Dir}/libopenal.a"							OPENAL_LIBRARY_RELEASE	OPENAL_LIBRARY)
endif()

dk_set(openal_CMAKE
	-DOPENAL_INCLUDE_DIR=${OPENAL_INCLUDE_DIR} 
	-DOPENAL_LIBRARY=${OPENAL_LIBRARY} 
	-DOPENAL_LIBRARY_DEBUG=${OPENAL_LIBRARY_DEBUG}
	-DOPENAL_LIBRARY_RELEASE=${OPENAL_LIBRARY_RELEASE})
if(MSVC)
	dk_append(openal_CMAKE
		"-DCMAKE_C_FLAGS=/DAL_LIBTYPE_STATIC /I${OPENAL_INCLUDE_DIR}"
		"-DCMAKE_CXX_FLAGS=/DAL_LIBTYPE_STATIC /I${OPENAL_INCLUDE_DIR}")
else()
	dk_append(openal_CMAKE
		"-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL_INCLUDE_DIR}"
		"-DCMAKE_CXX_FLAGS=-DAL_LIBTYPE_STATIC -I${OPENAL_INCLUDE_DIR}")
endif()	



### GENERATE ###
#if(Unix)
	dk_configure(${openal} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${ogg_CMAKE} ${vorbis_CMAKE} ${flac_CMAKE})
#elseif(Windows)
#	dk_configure(${openal} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${ogg_CMAKE} ${vorbis_CMAKE} ${flac_CMAKE} -DFORCE_STATIC_VCRT=ON "-DCMAKE_C_FLAGS=-DAL_LIBTYPE_STATIC")
#endif()


### COMPILE ###
if(Android)
	dk_ndk()
else()
	dk_build(${openal} OpenAL)
endif()
