## https://github.com/vancegroup/freealut

DKSET(FREEALUT_VERSION master)
DKSET(FREEALUT_NAME freealut-${FREEALUT_VERSION})
#DKSET(FREEALUT_DL ???)
DKSET(FREEALUT ${3RDPARTY}/${FREEALUT_NAME})


### INSTALL ###
DKINSTALL(${FREEALUT_DL} freealut-master ${FREEALUT})


### LINK ###
DKINCLUDE(${FREEALUT}/include)
ANDROID_DEBUG_LIB(${FREEALUT}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libalut.a)
ANDROID_RELEASE_LIB(${FREEALUT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libalut.a)


### COMPILE ###
ANDROID_NDK(${FREEALUT_NAME})