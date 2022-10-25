# https://github.com/mirror/libX11.git
# https://www.x.org/
# https://www.x.org/releases/individual/lib/
# https://www.x.org/releases/individual/lib/libX11-1.6.10.tar.gz
# https://github.com/mirror/libX11/archive/refs/tags/libX11-1.7.0.zip


### IMPORT ###
dk_import(https://github.com/mirror/libX11/archive/refs/tags/libx11-1.7.0.zip)


### LINK ###
dk_include(${LIBX11}/include)
WIN_dk_libDebug(${LIBX11}/${OS}/${DEBUG_DIR}/libx11d.lib)
WIN_dk_libRelease(${LIBX11}/${OS}/${RELEASE_DIR}/libx11.lib)
APPLE_dk_libDebug(${LIBX11}/${OS}/${DEBUG_DIR}/liblibx11d.a)
APPLE_dk_libRelease(${LIBX11}/${OS}/${RELEASE_DIR}/liblibx11.a)
LINUX_dk_libDebug(${LIBX11}/${OS}/${DEBUG_DIR}/liblibx11d.a)
LINUX_dk_libRelease(${LIBX11}/${OS}/${RELEASE_DIR}/liblibx11.a)
RASPBERRY_dk_libDebug(${LIBX11}/${OS}/${DEBUG_DIR}/liblibx11d.a)
RASPBERRY_dk_libRelease(${LIBX11}/${OS}/${RELEASE_DIR}/liblibx11.a)
ANDROID_dk_libDebug(${LIBX11}/${OS}/${DEBUG_DIR}/liblibx11d.a)
ANDROID_dk_libRelease(${LIBX11}/${OS}/${RELEASE_DIR}/liblibx11.a)


### COMPILE ###
WIN32_DEBUG_dk_setPath(${LIBX11}/${OS}/${DEBUG_DIR})
WIN32_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
WIN32_DEBUG_dk_msys(make)
WIN32_RELEASE_dk_setPath(${LIBX11}/${OS}/${RELEASE_DIR})
WIN32_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
WIN32_RELEASE_dk_msys(make)


WIN64_DEBUG_dk_setPath(${LIBX11}/${OS}/${DEBUG_DIR})
WIN64_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
WIN64_DEBUG_dk_msys(make)
WIN64_RELEASE_dk_setPath(${LIBX11}/${OS}/${RELEASE_DIR})
WIN64_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
WIN64_RELEASE_dk_msys(make)


MAC_DEBUG_dk_setPath(${LIBX11}/${OS}/${DEBUG_DIR})
MAC_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_DEBUG_dk_queueCommand(make)
MAC_RELEASE_dk_setPath(${LIBX11}/${OS}/${RELEASE_DIR})
MAC_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_RELEASE_dk_queueCommand(make)


IOS_DEBUG_dk_setPath(${LIBX11}/${OS}/${DEBUG_DIR})
IOS_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOS_DEBUG_dk_queueCommand(make)
IOS_RELEASE_dk_setPath(${LIBX11}/${OS}/${RELEASE_DIR})
IOS_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOS_RELEASE_dk_queueCommand(make)


IOSSIM_DEBUG_dk_setPath(${LIBX11}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOSSIM_DEBUG_dk_queueCommand(make)
IOSSIM_RELEASE_dk_setPath(${LIBX11}/${OS}/${RELEASE_DIR})
IOSSIM_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOSSIM_RELEASE_dk_queueCommand(make)


LINUX_DEBUG_dk_setPath(${LIBX11}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_DEBUG_dk_queueCommand(make)
LINUX_RELEASE_dk_setPath(${LIBX11}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_RELEASE_dk_queueCommand(make)


RASPBERRY_DEBUG_dk_setPath(${LIBX11}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_DEBUG_dk_queueCommand(make)
RASPBERRY_RELEASE_dk_setPath(${LIBX11}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_RELEASE_dk_queueCommand(make)


ANDROID_DEBUG_dk_setPath(${LIBX11}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
ANDROID_DEBUG_dk_msys(make)
ANDROID_RELEASE_dk_setPath(${LIBX11}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
ANDROID_RELEASE_dk_msys(make)
