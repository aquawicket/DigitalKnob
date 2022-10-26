# https://github.com/guillemj/libmd

if(NOT IOSSIM)
	return()
endif()


### DEPEND ###
dk_depend(autotools)


dk_import(https://github.com/guillemj/libmd)
#dk_set(LIBMD_VERSION 1.0.4)
#dk_set(LIBMD_FOLDER libmd-${LIBMD_VERSION})
#dk_set(LIBMD_DL https://github.com/guillemj/libmd/archive/refs/tags/1.0.4.zip)
#dk_set(LIBMD ${3RDPARTY}/${LIBMD_FOLDER})
#dk_import(${LIBMD_DL} ${LIBMD} NOPATCH)


### LINK ###
dk_include(${LIBMD}/include)
WIN_dk_libDebug(${LIBMD}/${OS}/${DEBUG_DIR}/libmdd.lib)
WIN_dk_libRelease(${LIBMD}/${OS}/${RELEASE_DIR}/libmd.lib)
APPLE_dk_libDebug(${LIBMD}/${OS}/${DEBUG_DIR}/liblibmdd.a)
APPLE_dk_libRelease(${LIBMD}/${OS}/${RELEASE_DIR}/liblibmd.a)
LINUX_dk_libDebug(${LIBMD}/${OS}/${DEBUG_DIR}/liblibmdd.a)
LINUX_dk_libRelease(${LIBMD}/${OS}/${RELEASE_DIR}/liblibmd.a)
RASPBERRY_dk_libDebug(${LIBMD}/${OS}/${DEBUG_DIR}/liblibmdd.a)
RASPBERRY_dk_libRelease(${LIBMD}/${OS}/${RELEASE_DIR}/liblibmd.a)
ANDROID_dk_libDebug(${LIBMD}/${OS}/${DEBUG_DIR}/liblibmdd.a)
ANDROID_dk_libRelease(${LIBMD}/${OS}/${RELEASE_DIR}/liblibmd.a)


### 3RDPARTY LINK ###
WIN_dk_set(LIBMD_CMAKE -DLIBMD_LIBRARY=${LIBMD}/${OS}/${DEBUG_DIR}/libmd.a)
APPLE_dk_set(LIBMD_CMAKE -DLIBMD_LIBRARY=${LIBMD}/${OS}/${DEBUG_DIR}/libmd.a)
LINUX_dk_set(LIBMD_CMAKE -DLIBMD_LIBRARY=${LIBMD}/${OS}/${DEBUG_DIR}/libmd.a)
RASPBERRY_dk_set(LIBMD_CMAKE -DLIBMD_LIBRARY=${LIBMD}/${OS}/${DEBUG_DIR}/libmd.a)
ANDROID_dk_set(LIBMD_CMAKE -DLIBMD_LIBRARY=${LIBMD}/${OS}/${DEBUG_DIR}/libmd.a)


### COMPILE ###
WIN32_DEBUG_dk_setPath(${LIBMD}/${OS}/${DEBUG_DIR})
WIN32_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
WIN32_DEBUG_dk_msys(make)
WIN32_RELEASE_dk_setPath(${LIBMD}/${OS}/${RELEASE_DIR})
WIN32_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
WIN32_RELEASE_dk_msys(make)


WIN64_DEBUG_dk_setPath(${LIBMD}/${OS}/${DEBUG_DIR})
WIN64_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
WIN64_DEBUG_dk_msys(make)
WIN64_RELEASE_dk_setPath(${LIBMD}/${OS}/${RELEASE_DIR})
WIN64_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
WIN64_RELEASE_dk_msys(make)


MAC_DEBUG_dk_setPath(${LIBMD})
MAC_DEBUG_dk_queueCommand(aclocal)
MAC_DEBUG_dk_setPath(${LIBMD}/${OS}/${DEBUG_DIR})
MAC_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_DEBUG_dk_queueCommand(make)
MAC_RELEASE_dk_setPath(${LIBMD}/${OS}/${RELEASE_DIR})
MAC_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_RELEASE_dk_queueCommand(make)


IOS_DEBUG_dk_setPath(${LIBMD}/${OS}/${DEBUG_DIR})
IOS_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOS_DEBUG_dk_queueCommand(make)
IOS_RELEASE_dk_setPath(${LIBMD}/${OS}/${RELEASE_DIR})
IOS_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOS_RELEASE_dk_queueCommand(make)


IOSSIM_DEBUG_dk_setPath(${LIBMD}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOSSIM_DEBUG_dk_queueCommand(make)
IOSSIM_RELEASE_dk_setPath(${LIBMD}/${OS}/${RELEASE_DIR})
IOSSIM_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOSSIM_RELEASE_dk_queueCommand(make)


LINUX_DEBUG_dk_setPath(${LIBMD}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_DEBUG_dk_queueCommand(make)
LINUX_RELEASE_dk_setPath(${LIBMD}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_RELEASE_dk_queueCommand(make)


RASPBERRY_DEBUG_dk_setPath(${LIBMD}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_DEBUG_dk_queueCommand(make)
RASPBERRY_RELEASE_dk_setPath(${LIBMD}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_RELEASE_dk_queueCommand(make)


ANDROID_dk_ndk(${LIBMD_FOLDER})
#ANDROID_DEBUG_dk_setPath(${LIBMD}/${OS}/${DEBUG_DIR})
#ANDROID_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
#ANDROID_DEBUG_dk_msys(make)
#ANDROID_RELEASE_dk_setPath(${LIBMD}/${OS}/${RELEASE_DIR})
#ANDROID_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
#ANDROID_RELEASE_dk_msys(make)
