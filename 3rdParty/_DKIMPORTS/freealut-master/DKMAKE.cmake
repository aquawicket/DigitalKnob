## https://github.com/vancegroup/freealut


### INSTALL ###
dk_set(FREEALUT_VERSION master)
dk_set(FREEALUT_NAME freealut-${FREEALUT_VERSION})
#dk_set(FREEALUT_DL ???)
dk_set(FREEALUT ${3RDPARTY}/${FREEALUT_NAME})
dk_import(${FREEALUT_DL} ${FREEALUT})


### LINK ###
dk_include(${FREEALUT}/include)
ANDROID_dk_libDebug(${FREEALUT}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libalut.a)
ANDROID_dk_libRelease(${FREEALUT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libalut.a)


### COMPILE ###
ANDROID_dk_ndk(${FREEALUT_NAME})