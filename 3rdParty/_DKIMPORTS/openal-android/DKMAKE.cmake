# https://openal.org/
# https://openal-soft.org/
#
# https://github.com/native-toolkit/openal-android
# https://openal.org/downloads/OpenAL11CoreSDK.zip

### VERSION ###
DKSET(OPENAL_VERSION 11)
DKSET(OPENAL_NAME openal-${OPENAL_VERSION})
DKSET(OPENAL_DL https://openal.org/downloads/OpenAL${OPENAL_VERSION}CoreSDK.zip)
DKSET(OPENAL ${3RDPARTY}/${OPENAL_NAME})


### INSTALL ###
DKINSTALL(${OPENAL_DL} OpenAL-android ${OPENAL})


### LINK ###
DKDEFINE(AL_LIBTYPE_STATIC)
ANDROID_INCLUDE(${OPENAL}/include)
ANDROID_INCLUDE(${OPENAL}/include/AL)
ANDROID_INCLUDE(${OPENAL}/${OS}/${RELEASE_DIR}/jni)
ANDROID_DEBUG_LIB(${OPENAL}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libopenal.a)
ANDROID_RELEASE_LIB(${OPENAL}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libopenal.a)


### COMPILE ###
ANDROID_NDK(${OPENAL_NAME})