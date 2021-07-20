## https://github.com/vancegroup/freealut

DKSET(FREEALUT ${3RDPARTY}/freealut-master)


### INSTALL ###
## DKINSTALL(www.internet.com/freealut-master.zip freealut-master) ## find an online link


### LINK ###
DKINCLUDE(${FREEALUT}/include)
ANDROID_DEBUG_LIB(${FREEALUT}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libalut.a)
ANDROID_RELEASE_LIB(${FREEALUT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libalut.a)


### COMPILE ###
ANDROID_NDK(freealut-master)