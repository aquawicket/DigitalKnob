## https://github.com/vancegroup/freealut


### INSTALL ###
dk_set(FREEALUT_VERSION master)
dk_set(FREEALUT_NAME freealut-${FREEALUT_VERSION})
#dk_set(FREEALUT_DL ???)
dk_set(FREEALUT ${3RDPARTY}/${FREEALUT_NAME})
dk_install(${FREEALUT_DL} freealut_master ${FREEALUT})


### LINK ###
dk_include(${FREEALUT}/include)
ANDROID_DEBUG_DKLIB(${FREEALUT}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libalut.a)
ANDROID_RELEASE_DKLIB(${FREEALUT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libalut.a)


### COMPILE ###
ANDROID_NDK(${FREEALUT_NAME})