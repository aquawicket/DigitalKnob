return() # migrated to /_DKIMPORTS/openal/DKMAKE.cmake

# https://openal.org/
# https://openal-soft.org/
# https://github.com/native-toolkit/openal-android
# https://openal.org/downloads/OpenAL11CoreSDK.zip
if(NOT ANDROID)
	return()
endif()


dk_import(https://openal.org/downloads/OpenAL11CoreSDK.zip)


### LINK ###
dk_define(AL_LIBTYPE_STATIC)
ANDROID_dk_include(${OPENAL}/include)
ANDROID_dk_include(${OPENAL}/include/AL)
ANDROID_dk_include(${OPENAL}/${OS}/${RELEASE_DIR}/jni)
ANDROID_dk_libDebug(${OPENAL}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libopenal.a)
ANDROID_dk_libRelease(${OPENAL}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libopenal.a)


### COMPILE ###
ANDROID_dk_ndk(${OPENAL_NAME})
