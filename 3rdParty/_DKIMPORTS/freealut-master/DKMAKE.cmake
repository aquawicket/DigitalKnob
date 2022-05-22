## https://github.com/vancegroup/freealut


### INSTALL ###
DKSET(FREEALUT_VERSION master)
DKSET(FREEALUT_NAME freealut-${FREEALUT_VERSION})
#DKSET(FREEALUT_DL ???)
DKSET(FREEALUT ${3RDPARTY}/${FREEALUT_NAME})
DKINSTALL(${FREEALUT_DL} freealut_master ${FREEALUT})


### LINK ###
DKINCLUDE(${FREEALUT}/include)
ANDROID_DEBUG_DKLIB(${FREEALUT}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libalut.a)
ANDROID_RELEASE_DKLIB(${FREEALUT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libalut.a)


### COMPILE ###
ANDROID_NDK(${FREEALUT_NAME})