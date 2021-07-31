if(NOT ANDROID) 
message("OpenAL-android is only for android devices") 
return() 
endif()


### INSTALL ###
## DKINSTALL(www.internet.com/OpenAL-android.zip OpenAL-android OpenAL-android)


### LINK ###
DKSET(OPENAL ${3RDPARTY}/OpenAL-android)
ANDROID_INCLUDE(${OPENAL}/include)
ANDROID_INCLUDE(${OPENAL}/include/AL)
ANDROID_INCLUDE(${OPENAL}/${OS}/${RELEASE_DIR}/jni)
DKDEFINE(AL_LIBTYPE_STATIC)
ANDROID_DEBUG_LIB(${OPENAL}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libopenal.a)
ANDROID_RELEASE_LIB(${OPENAL}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libopenal.a)


### COMPILE ###
ANDROID_NDK(OpenAL-android)