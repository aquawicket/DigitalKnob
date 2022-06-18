# http://giflib.sourceforge.net
# https://github.com/mirrorer/giflib
#
# https://sourceforge.net/projects/giflib/files/giflib-5.1.1.tar.gz

if(WIN_32)
	dk_depend(mingw32)
endif()
if(WIN_64)
	dk_depend(mingw64)
endif()
WIN_dk_depend(msys)
#WIN_dk_depend(msys2)


dk_import(https://github.com/mirrorer/giflib.git PATCH)

#dk_import(https://github.com/mirrorer/giflib/archive/fa37672085ce4b3d62c51627ab3c8cf2dda8009a.zip PATCH)

#dk_set(GIFLIB_VERSION 5.1.1)
#dk_set(GIFLIB_DL https://sourceforge.net/projects/giflib/files/giflib-5.1.1.tar.gz)
#dk_set(GIFLIB_NAME giflib-${GIFLIB_VERSION})
#dk_set(GIFLIB ${3RDPARTY}/${GIFLIB_NAME})
#dk_install(${GIFLIB_DL} giflib ${GIFLIB} PATCH)



### DKPLUGINS LINK ###
dk_include(${GIFLIB}/lib)
WIN_dk_libDebug(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
WIN_dk_libRelease(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
APPLE_dk_libDebug(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
APPLE_dk_libRelease(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
LINUX_dk_libDebug(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
LINUX_dk_libRelease(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
RASPBERRY_dk_libDebug(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
RASPBERRY_dk_libRelease(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
ANDROID_dk_libDebug(${GIFLIB}/${OS}/${DEBUG_DIR}/libgiflib.a)
ANDROID_dk_libRelease(${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)



### 3RDPARTY LINK ###
WIN_dk_set(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
APPLE_dk_set(GIF_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
LINUX_dk_set(GIF_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
RASPBERRY_dk_set(GIF_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
ANDROID_dk_set(GIF_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)	


### COMPILE ###
WIN32_DEBUG_dk_setPath(${GIFLIB}/${OS}/${DEBUG_DIR})
WIN32_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
WIN32_DEBUG_dk_msys(make -C lib)
WIN32_RELEASE_dk_setPath(${GIFLIB}/${OS}/${RELEASE_DIR})
WIN32_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
WIN32_RELEASE_dk_msys(make -C lib)


WIN64_DEBUG_dk_setPath(${GIFLIB}/${OS}/${DEBUG_DIR})
WIN64_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
WIN64_DEBUG_dk_msys(make -C lib)
WIN64_RELEASE_dk_setPath(${GIFLIB}/${OS}/${RELEASE_DIR})
WIN64_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
WIN64_RELEASE_dk_msys(make -C lib)


MAC_DEBUG_dk_setPath(${GIFLIB}/${OS}/${DEBUG_DIR})
MAC_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_DEBUG_dk_queueCommand(make -C lib)
MAC_RELEASE_dk_setPath(${GIFLIB}/${OS}/${RELEASE_DIR})
MAC_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_RELEASE_dk_queueCommand(make -C lib)


IOS_DEBUG_dk_setPath(${GIFLIB}/${OS}/${DEBUG_DIR})
IOS_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOS_DEBUG_dk_queueCommand(make -C lib)
IOS_RELEASE_dk_setPath(${GIFLIB}/${OS}/${RELEASE_DIR})
IOS_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
IOS_RELEASE_dk_queueCommand(make -C lib)


IOSSIM_DEBUG_dk_setPath(${GIFLIB}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOSSIM_DEBUG_dk_queueCommand(make -C lib)
IOSSIM_RELEASE_dk_setPath(${GIFLIB}/${OS}/${RELEASE_DIR})
IOSSIM_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
IOSSIM_RELEASE_dk_queueCommand(make -C lib)


LINUX_DEBUG_dk_setPath(${GIFLIB}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_DEBUG_dk_queueCommand(make -C lib)
LINUX_RELEASE_dk_setPath(${GIFLIB}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_RELEASE_dk_queueCommand(make -C lib)


RASPBERRY_DEBUG_dk_setPath(${GIFLIB}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_DEBUG_dk_queueCommand(make -C lib)
RASPBERRY_RELEASE_dk_setPath(${GIFLIB}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_RELEASE_dk_queueCommand(make -C lib)



dk_setPath(${GIFLIB}/${BUILD_DIR})
ANDROID_dk_queueCommand(${DKCMAKE_BUILD} ${GIFLIB})
ANDROID_dk_VisualStudio(${GIFLIB_NAME} giflib.sln giflib)