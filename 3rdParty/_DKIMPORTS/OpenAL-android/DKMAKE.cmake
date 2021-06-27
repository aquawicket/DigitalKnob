IF(NOT ANDROID)
	RETURN()
ENDIF()


### INSTALL ###
## DKINSTALL(www.internet.com/OpenAL-android.zip OpenAL-android OpenAL-android)


### LINK ###
DKSET(OPENAL ${3RDPARTY}/OpenAL-android)
ANDROID_INCLUDE(${OPENAL}/include)
ANDROID_INCLUDE(${OPENAL}/include/AL)
ANDROID_INCLUDE(${OPENAL}/${OS}/Release/jni)
DKDEFINE(AL_LIBTYPE_STATIC)
ANDROID_DEBUG_LIB(${OPENAL}/${OS}/Debug/obj/local/armeabi-v7a/libopenal.a)
ANDROID_RELEASE_LIB(${OPENAL}/${OS}/Release/obj/local/armeabi-v7a/libopenal.a)


### COMPILE ###
ANDROID_NDK_DEBUG(OpenAL-android)
ANDROID_NDK_RELEASE(OpenAL-android)