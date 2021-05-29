IF(NOT ANDROID)
	RETURN()
ENDIF()


### INSTALL ###
## DKINSTALL(www.internet.com/freealut-master.zip freealut-master) ## find an online link
DKSET(FREEALUT ${3RDPARTY}/freealut-master)


### LINK ###
DKINCLUDE(${FREEALUT}/include)
ANDROID_DEBUG_LIB(${FREEALUT}/${OS}/Debug/obj/local/armeabi-v7a/libalut.a)
ANDROID_RELEASE_LIB(${FREEALUT}/${OS}/Release/obj/local/armeabi-v7a/libalut.a)


### COMPILE ###
ANDROID_NDK_DEBUG(freealut-master)
ANDROID_NDK_RELEASE(freealut-master)