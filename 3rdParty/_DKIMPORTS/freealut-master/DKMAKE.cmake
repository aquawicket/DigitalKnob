return() # migrated to /_DKIMPORTS/freealut/DKMAKE.cmake
## https://github.com/vancegroup/freealut


### INSTALL ###
dk_set(FREEALUT-MASTER_VERSION master)
dk_set(FREEALUT-MASTER_NAME freealut-${FREEALUT-MASTER_VERSION})
#dk_set(FREEALUT-MASTER_DL ???)
dk_set(FREEALUT-MASTER ${3RDPARTY}/${FREEALUT-MASTER_NAME})
dk_import(${FREEALUT-MASTER_DL} ${FREEALUT-MASTER})


### LINK ###
dk_include(${FREEALUT-MASTER}/include)
ANDROID_dk_libDebug(${FREEALUT-MASTER}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libalut.a)
ANDROID_dk_libRelease(${FREEALUT-MASTER}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libalut.a)


### COMPILE ###
ANDROID_dk_ndk(${FREEALUT-MASTER_NAME})