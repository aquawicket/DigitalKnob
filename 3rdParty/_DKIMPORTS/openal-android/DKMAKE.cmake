if(NOT ANDROID)
	return()
endif()

# https://openal.org/
# https://openal-soft.org/
#
# https://github.com/native-toolkit/openal-android
# https://openal.org/downloads/OpenAL11CoreSDK.zip

### VERSION ###
dk_set(OPENAL_VERSION 11)
dk_set(OPENAL_NAME openal-${OPENAL_VERSION})
dk_set(OPENAL_DL https://openal.org/downloads/OpenAL${OPENAL_VERSION}CoreSDK.zip)
dk_set(OPENAL ${3RDPARTY}/${OPENAL_NAME})


### INSTALL ###
dk_install(${OPENAL_DL} OpenAL-android ${OPENAL})


### LINK ###
dk_define(AL_LIBTYPE_STATIC)
ANDROID_dk_include(${OPENAL}/include)
ANDROID_dk_include(${OPENAL}/include/AL)
ANDROID_dk_include(${OPENAL}/${OS}/${RELEASE_DIR}/jni)
ANDROID_DEBUG_DKLIB(${OPENAL}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libopenal.a)
ANDROID_RELEASE_DKLIB(${OPENAL}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libopenal.a)


### COMPILE ###
ANDROID_NDK(${OPENAL_NAME})