# https://openal.org/
# https://openal-soft.org/
# https://github.com/native-toolkit/openal-android
# https://openal.org/downloads/OpenAL11CoreSDK.zip
# https://www.openal-soft.org/openal-releases/openal-soft-1.15.1.tar.bz2
# https://www.openal-soft.org/openal-releases/openal-soft-1.21.1.tar.bz2


WIN_dk_depend(winmm.lib)

if(ANDROID)
	dk_import(https://openal.org/downloads/OpenAL11CoreSDK.zip)
else()
	dk_import(https://www.openal-soft.org/openal-releases/openal-soft-1.21.1.tar.bz2)
endif()



### LINK ###
dk_define(AL_LIBTYPE_STATIC)
dk_include(${OPENAL}/include)
dk_include(${OPENAL}/include/AL)
ANDROID_dk_include(${OPENAL}/${OS}/${RELEASE_DIR}/jni)

file(REMOVE ${OPENAL}/include/AL/stdint.h)
file(REMOVE ${OPENAL}/include/AL/inttypes.h)
WIN_dk_libDebug(${OPENAL}/${OS}/${DEBUG_DIR}/OpenAL32.lib)
WIN_dk_libRelease(${OPENAL}/${OS}/${RELEASE_DIR}/OpenAL32.lib)
APPLE_dk_libDebug(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
APPLE_dk_libRelease(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
LINUX_dk_libDebug(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
LINUX_dk_libRelease(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
RASPBERRY_dk_libDebug(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
RASPBERRY_dk_libRelease(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
#ANDROID_dk_libDebug(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
#ANDROID_dk_libRelease(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
ANDROID_dk_libDebug(${OPENAL}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libopenal.a)
ANDROID_dk_libRelease(${OPENAL}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libopenal.a)


WIN_dk_set				(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY_DEBUG=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a -DOPENAL_LIBRARY_RELEASE=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
APPLE_dk_set			(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY_DEBUG=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a -DOPENAL_LIBRARY_RELEASE=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
LINUX_DEBUG_dk_set		(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
LINUX_RELEASE_dk_set	(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
RASPBERRY_DEBUG_dk_set	(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
RASPBERRY_RELEASE_dk_set(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
ANDROID_dk_set			(OPENAL_CMAKE -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a -DOPENAL_LIBRARY_DEBUG=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a -DOPENAL_LIBRARY_RELEASE=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)


### GENERATE ###
dk_setPath(${OPENAL}/${BUILD_DIR})
WIN_dk_queueCommand			(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} -DFORCE_STATIC_VCRT=ON "-DCMAKE_C_FLAGS=/DAL_LIBTYPE_STATIC"  ${OPENAL})
MAC_dk_queueCommand			(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})
IOS_dk_queueCommand			(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})
IOSSIM_dk_queueCommand		(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})
LINUX_dk_queueCommand		(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})
RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})
#ANDROID_dk_queueCommand	(${DKCMAKE_BUILD} -DLIBTYPE=STATIC -DEXAMPLES=OFF ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${OPENAL})


### COMPILE ###
if(NOT ANDROID)
	dk_visualStudio(${OPENAL_NAME} OpenAL)
else()
	ANDROID_dk_ndk(${OPENAL_NAME})
endif()
dk_xcode(${OPENAL_NAME} OpenAL)
LINUX_dk_queueCommand(make)
RASPBERRY_dk_queueCommand(make)
