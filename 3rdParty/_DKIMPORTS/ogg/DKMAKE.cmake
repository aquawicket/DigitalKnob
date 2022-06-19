# https://github.com/xiph/ogg
# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies
# https://ftp.osuosl.org/pub/xiph/releases/ogg

dk_depend(msys)

#DKIMORT(https://github.com/xiph/ogg)
dk_set(OGG_VERSION 1.3.5)
dk_set(OGG_DL https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.zip)
dk_set(OGG_NAME libogg-${OGG_VERSION})
dk_set(OGG ${3RDPARTY}/${OGG_NAME})
dk_install(${OGG_DL} ogg ${OGG})


### DKPLUGINS LINK ###
dk_include(${OGG}/include)
dk_include(${OGG}/${OS}/${DEBUG_DIR}/include)
dk_include(${OGG}/${OS}/${RELEASE_DIR}/include)
WIN_dk_libDebug(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
WIN_dk_libRelease(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
APPLE_dk_libDebug(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
APPLE_dk_libRelease(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
LINUX_dk_libDebug(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
LINUX_dk_libRelease(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
RASPBERRY_dk_libDebug(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
RASPBERRY_dk_libRelease(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
ANDROID_dk_libDebug(${OGG}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libogg.a)
ANDROID_dk_libRelease(${OGG}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libogg.a)


### 3RDPARTY LINK ###
WIN_DEBUG_dk_set(OGG_CONFIGURE CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs)
WIN_RELEASE_dk_set(OGG_CONFIGURE CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs)
APPLE_DEBUG_dk_set(OGG_CONFIGURE CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs)
APPLE_RELEASE_dk_set(OGG_CONFIGURE CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs)
LINUX_DEBUG_dk_set(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include)
LINUX_RELEASE_dk_set(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include)
RASPBERRY_DEBUG_dk_set(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include)
RASPBERRY_RELEASE_dk_set(OGG_CONFIGURE CPPFLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include)
ANDROID_DEBUG_dk_set(OGG_CONFIGURE CFLAGS=-I${OGG}/include -I${OGG}/${OS}/${DEBUG_DIR}/include --with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs)
ANDROID_RELEASE_dk_set(OGG_CONFIGURE CFLAGS=-I${OGG}/include -I${OGG}/${OS}/${RELEASE_DIR}/include --with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs)


WIN_DEBUG_dk_set(OGG_CMAKE "-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include" -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
APPLE_DEBUG_dk_set(OGG_CMAKE "-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include" -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
LINUX_DEBUG_dk_set(OGG_CMAKE "-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include" -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
RASPBERRY_DEBUG_dk_set(OGG_CMAKE "-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include" -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
ANDROID_DEBUG_dk_set(OGG_CMAKE "-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${DEBUG_DIR}/include" -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
WIN_RELEASE_dk_set(OGG_CMAKE "-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include" -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
APPLE_RELEASE_dk_set(OGG_CMAKE "-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include" -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
LINUX_RELEASE_dk_set(OGG_CMAKE "-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include" -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
RASPBERRY_RELEASE_dk_set(OGG_CMAKE "-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include" -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
ANDROID_RELEASE_dk_set(OGG_CMAKE "-DCMAKE_CXX_FLAGS=-I${OGG}/${OS}/${RELEASE_DIR}/include" -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)

	
### COMPILE ###
WIN_DEBUG_dk_setPath(${OGG}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
WIN_DEBUG_dk_msys(make)
WIN_RELEASE_dk_setPath(${OGG}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
WIN_RELEASE_dk_msys(make)


MAC_DEBUG_dk_setPath(${OGG}/${OS}/${DEBUG_DIR})
MAC_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_DEBUG_dk_queueCommand(make)
MAC_RELEASE_dk_setPath(${OGG}/${OS}/${RELEASE_DIR})
MAC_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_RELEASE_dk_queueCommand(make)


IOS_DEBUG_dk_setPath(${OGG}/${OS}/${DEBUG_DIR})
IOS_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOS_DEBUG_dk_queueCommand(make)
IOS_RELEASE_dk_setPath(${OGG}/${OS}/${RELEASE_DIR})
IOS_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
IOS_RELEASE_dk_queueCommand(make)


IOSSIM_DEBUG_dk_setPath(${OGG}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOSSIM_DEBUG_dk_queueCommand(make)
IOSSIM_RELEASE_dk_setPath(${OGG}/${OS}/${RELEASE_DIR})
IOSSIM_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
IOSSIM_RELEASE_dk_queueCommand(make)


LINUX_DEBUG_dk_setPath(${OGG}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_DEBUG_dk_queueCommand(make)
LINUX_RELEASE_dk_setPath(${OGG}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_RELEASE_dk_queueCommand(make)


RASPBERRY_DEBUG_dk_setPath(${OGG}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_DEBUG_dk_queueCommand(make)
RASPBERRY_RELEASE_dk_setPath(${OGG}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_RELEASE_dk_queueCommand(make)


#ANDROID_dk_ndk(${OGG_NAME})
ANDROID_DEBUG_dk_setPath(${OGG}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
ANDROID_DEBUG_dk_msys(make)
ANDROID_RELEASE_dk_setPath(${OGG}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
ANDROID_RELEASE_dk_msys(make)